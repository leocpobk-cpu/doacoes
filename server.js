const express = require('express');
const cors = require('cors');
const path = require('path');
const { db, initializeDatabase, seedDatabase } = require('./database');

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Inicializa o banco
initializeDatabase();
seedDatabase();

// ==================== ROTAS API ====================

// GET - Lista todos os itens com suas doações
app.get('/api/itens', (req, res) => {
  try {
    const itens = db.prepare(`
      SELECT 
        i.*,
        ROUND((i.quantidade_doada * 100.0 / i.quantidade_total), 1) as percentual_doado
      FROM itens i
      ORDER BY i.id
    `).all();

    // Para cada item, busca as doações
    const itensComDoacoes = itens.map(item => {
      const doacoes = db.prepare(`
        SELECT * FROM doacoes 
        WHERE item_id = ? 
        ORDER BY created_at DESC
      `).all(item.id);

      return { ...item, doacoes };
    });

    res.json(itensComDoacoes);
  } catch (error) {
    console.error('Erro ao buscar itens:', error);
    res.status(500).json({ error: 'Erro ao buscar itens' });
  }
});

// GET - Busca um item específico
app.get('/api/itens/:id', (req, res) => {
  try {
    const item = db.prepare('SELECT * FROM itens WHERE id = ?').get(req.params.id);
    
    if (!item) {
      return res.status(404).json({ error: 'Item não encontrado' });
    }

    const doacoes = db.prepare(`
      SELECT * FROM doacoes 
      WHERE item_id = ? 
      ORDER BY created_at DESC
    `).all(item.id);

    res.json({ ...item, doacoes });
  } catch (error) {
    console.error('Erro ao buscar item:', error);
    res.status(500).json({ error: 'Erro ao buscar item' });
  }
});

// POST - Cria uma nova doação
app.post('/api/doacoes', (req, res) => {
  try {
    const { item_id, doador_nome, doador_regiao, quantidade, tipo, valor_dinheiro, observacao } = req.body;

    // Validações
    if (!item_id || !doador_nome || !quantidade || !tipo) {
      return res.status(400).json({ error: 'Dados obrigatórios faltando' });
    }

    if (tipo !== 'item' && tipo !== 'dinheiro') {
      return res.status(400).json({ error: 'Tipo deve ser "item" ou "dinheiro"' });
    }

    // Verifica se o item existe
    const item = db.prepare('SELECT * FROM itens WHERE id = ?').get(item_id);
    if (!item) {
      return res.status(404).json({ error: 'Item não encontrado' });
    }

    // Verifica se não ultrapassa a quantidade total
    const novaQuantidadeDoada = item.quantidade_doada + quantidade;
    if (novaQuantidadeDoada > item.quantidade_total) {
      return res.status(400).json({ 
        error: `Quantidade excede o total necessário. Restam ${item.quantidade_total - item.quantidade_doada} ${item.unidade}` 
      });
    }

    // Insere a doação em uma transação
    const insertDoacao = db.transaction(() => {
      const result = db.prepare(`
        INSERT INTO doacoes (item_id, doador_nome, doador_regiao, quantidade, tipo, valor_dinheiro, observacao)
        VALUES (?, ?, ?, ?, ?, ?, ?)
      `).run(item_id, doador_nome, doador_regiao || null, quantidade, tipo, valor_dinheiro || null, observacao || null);

      // Atualiza quantidade_doada no item
      db.prepare(`
        UPDATE itens 
        SET quantidade_doada = quantidade_doada + ?,
            updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
      `).run(quantidade, item_id);

      return result;
    });

    const result = insertDoacao();

    res.status(201).json({ 
      id: result.lastInsertRowid, 
      message: 'Doação registrada com sucesso!' 
    });
  } catch (error) {
    console.error('Erro ao criar doação:', error);
    res.status(500).json({ error: 'Erro ao registrar doação' });
  }
});

// DELETE - Remove uma doação
app.delete('/api/doacoes/:id', (req, res) => {
  try {
    const doacao = db.prepare('SELECT * FROM doacoes WHERE id = ?').get(req.params.id);
    
    if (!doacao) {
      return res.status(404).json({ error: 'Doação não encontrada' });
    }

    // Remove a doação e atualiza o item em uma transação
    const deleteDoacao = db.transaction(() => {
      db.prepare('DELETE FROM doacoes WHERE id = ?').run(req.params.id);
      
      db.prepare(`
        UPDATE itens 
        SET quantidade_doada = quantidade_doada - ?,
            updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
      `).run(doacao.quantidade, doacao.item_id);
    });

    deleteDoacao();

    res.json({ message: 'Doação removida com sucesso!' });
  } catch (error) {
    console.error('Erro ao remover doação:', error);
    res.status(500).json({ error: 'Erro ao remover doação' });
  }
});

// GET - Estatísticas gerais
app.get('/api/estatisticas', (req, res) => {
  try {
    const stats = db.prepare(`
      SELECT 
        COUNT(*) as total_itens,
        SUM(CASE WHEN quantidade_doada >= quantidade_total THEN 1 ELSE 0 END) as itens_completos,
        SUM(CASE WHEN quantidade_doada > 0 AND quantidade_doada < quantidade_total THEN 1 ELSE 0 END) as itens_parciais,
        SUM(CASE WHEN quantidade_doada = 0 THEN 1 ELSE 0 END) as itens_pendentes
      FROM itens
    `).get();

    const totalDoacoes = db.prepare('SELECT COUNT(*) as total FROM doacoes').get();
    const totalDoadores = db.prepare('SELECT COUNT(DISTINCT doador_nome) as total FROM doacoes').get();
    const totalDinheiro = db.prepare('SELECT COALESCE(SUM(valor_dinheiro), 0) as total FROM doacoes WHERE tipo = "dinheiro"').get();

    res.json({
      ...stats,
      total_doacoes: totalDoacoes.total,
      total_doadores: totalDoadores.total,
      total_dinheiro: totalDinheiro.total
    });
  } catch (error) {
    console.error('Erro ao buscar estatísticas:', error);
    res.status(500).json({ error: 'Erro ao buscar estatísticas' });
  }
});

// Rota principal - serve o HTML
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Inicia o servidor
app.listen(PORT, () => {
  console.log(`\n🚀 Servidor rodando em http://localhost:${PORT}`);
  console.log(`📊 Banco de dados: doacoes.db`);
  console.log(`\n⚡ Pronto para receber doações!\n`);
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('\n🛑 Encerrando servidor...');
  db.close();
  process.exit(0);
});
