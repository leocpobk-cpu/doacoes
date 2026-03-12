const Database = require('better-sqlite3');
const path = require('path');

// Cria o banco de dados SQLite
const db = new Database(path.join(__dirname, 'doacoes.db'));

// Habilita WAL mode para melhor concorrência
db.pragma('journal_mode = WAL');

// Cria as tabelas se não existirem
function initializeDatabase() {
  // Tabela de itens
  db.exec(`
    CREATE TABLE IF NOT EXISTS itens (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      quantidade_total REAL NOT NULL,
      unidade TEXT NOT NULL,
      quantidade_doada REAL DEFAULT 0,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);

  // Tabela de doações
  db.exec(`
    CREATE TABLE IF NOT EXISTS doacoes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      item_id INTEGER NOT NULL,
      doador_nome TEXT NOT NULL,
      doador_regiao TEXT,
      quantidade REAL NOT NULL,
      tipo TEXT NOT NULL CHECK(tipo IN ('item', 'dinheiro')),
      valor_dinheiro REAL,
      observacao TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (item_id) REFERENCES itens (id) ON DELETE CASCADE
    )
  `);

  // Índices para melhor performance
  db.exec(`
    CREATE INDEX IF NOT EXISTS idx_doacoes_item_id ON doacoes(item_id);
    CREATE INDEX IF NOT EXISTS idx_itens_created ON itens(created_at);
  `);

  console.log('✓ Banco de dados inicializado com sucesso');
}

// Popula com dados iniciais se a tabela estiver vazia
function seedDatabase() {
  const count = db.prepare('SELECT COUNT(*) as count FROM itens').get();
  
  if (count.count === 0) {
    console.log('Populando banco de dados com itens iniciais...');
    
    const itens = [
      { descricao: 'Arroz', quantidade_total: 5, unidade: 'pacotes' },
      { descricao: 'Coxa e sobrecoxa (cortada em 5 pedaços)', quantidade_total: 50, unidade: 'kg' },
      { descricao: 'Cebola', quantidade_total: 2, unidade: 'kg' },
      { descricao: 'Pimentão vermelho grande', quantidade_total: 3, unidade: 'unidades' },
      { descricao: 'Pimentão amarelo grande', quantidade_total: 3, unidade: 'unidades' },
      { descricao: 'Lata de milho grande', quantidade_total: 2, unidade: 'latas' },
      { descricao: 'Lata de selecta grande', quantidade_total: 2, unidade: 'latas' },
      { descricao: 'Alho', quantidade_total: 1, unidade: 'kg' },
      { descricao: 'Óleo', quantidade_total: 10, unidade: 'unidades' },
      { descricao: 'Tomate', quantidade_total: 2, unidade: 'kg' },
      { descricao: 'Sal', quantidade_total: 1, unidade: 'pacote' },
      { descricao: 'Maço de cebolinha', quantidade_total: 4, unidade: 'maços' },
      { descricao: 'Maço de salsa', quantidade_total: 3, unidade: 'maços' },
      { descricao: 'Cenoura', quantidade_total: 10, unidade: 'kg' },
      { descricao: 'Farinha', quantidade_total: 10, unidade: 'kg' },
      { descricao: 'Maço de couve', quantidade_total: 10, unidade: 'maços' },
      { descricao: 'Margarina', quantidade_total: 1, unidade: 'kg' },
      { descricao: 'Calabresa', quantidade_total: 1, unidade: 'pacote' },
      { descricao: 'Repolho grande', quantidade_total: 4, unidade: 'unidades' },
      { descricao: 'Pé de alface', quantidade_total: 10, unidade: 'pés' },
      { descricao: 'Bandeja de isopor', quantidade_total: 300, unidade: 'unidades' },
      { descricao: 'Garfo', quantidade_total: 300, unidade: 'unidades' },
      { descricao: 'Fardo de refrigerante', quantidade_total: 7, unidade: 'fardos' }
    ];

    const insert = db.prepare('INSERT INTO itens (descricao, quantidade_total, unidade) VALUES (?, ?, ?)');
    
    const insertMany = db.transaction((itens) => {
      for (const item of itens) {
        insert.run(item.descricao, item.quantidade_total, item.unidade);
      }
    });
    
    insertMany(itens);

    // Adiciona doações já existentes
    const doacoesExistentes = [
      { item_id: 1, doador_nome: 'Denner', doador_regiao: 'R13', quantidade: 2, tipo: 'item' },
      { item_id: 2, doador_nome: 'Denner', doador_regiao: 'R13', quantidade: 10, tipo: 'item' },
      { item_id: 8, doador_nome: 'Daniel Alves', doador_regiao: 'R09', quantidade: 1, tipo: 'item' },
      { item_id: 11, doador_nome: 'Daniel Alves', doador_regiao: 'R09', quantidade: 1, tipo: 'item' },
      { item_id: 14, doador_nome: 'Dc Lucas', doador_regiao: 'Figueiral', quantidade: 10, tipo: 'item' },
      { item_id: 15, doador_nome: 'Dc Lucas', doador_regiao: 'Figueiral', quantidade: 10, tipo: 'item' },
      { item_id: 16, doador_nome: 'Dc Lucas', doador_regiao: 'Figueiral', quantidade: 10, tipo: 'item' },
      { item_id: 17, doador_nome: 'Daniel Alves', doador_regiao: 'R09', quantidade: 1, tipo: 'item' },
      { item_id: 21, doador_nome: 'Damião', doador_regiao: 'R13', quantidade: 100, tipo: 'item' },
      { item_id: 23, doador_nome: 'Gabriel', doador_regiao: 'R04', quantidade: 1, tipo: 'dinheiro', valor_dinheiro: 40.00 }
    ];

    const insertDoacao = db.prepare(`
      INSERT INTO doacoes (item_id, doador_nome, doador_regiao, quantidade, tipo, valor_dinheiro) 
      VALUES (?, ?, ?, ?, ?, ?)
    `);

    const insertDoacoesMany = db.transaction((doacoes) => {
      for (const doacao of doacoes) {
        insertDoacao.run(
          doacao.item_id,
          doacao.doador_nome,
          doacao.doador_regiao,
          doacao.quantidade,
          doacao.tipo,
          doacao.valor_dinheiro || null
        );
      }
    });

    insertDoacoesMany(doacoesExistentes);

    // Atualiza quantidade_doada nos itens
    db.exec(`
      UPDATE itens SET quantidade_doada = (
        SELECT COALESCE(SUM(quantidade), 0) 
        FROM doacoes 
        WHERE doacoes.item_id = itens.id
      )
    `);

    console.log('✓ Banco de dados populado com sucesso');
  }
}

module.exports = { db, initializeDatabase, seedDatabase };
