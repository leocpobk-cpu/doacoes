-- ============================================
-- SCHEMA SUPABASE - SISTEMA DE DOAÇÕES
-- ============================================

-- Tabela de itens para doação
CREATE TABLE IF NOT EXISTS itens_doacao (
    id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    quantidade_total NUMERIC(10,2) NOT NULL DEFAULT 0,
    unidade TEXT NOT NULL,
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    atualizado_em TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela de doações registradas
CREATE TABLE IF NOT EXISTS doacoes (
    id SERIAL PRIMARY KEY,
    item_id INTEGER NOT NULL REFERENCES itens_doacao(id) ON DELETE CASCADE,
    doador_nome TEXT NOT NULL,
    doador_regiao TEXT,
    tipo_doacao TEXT NOT NULL CHECK (tipo_doacao IN ('item', 'dinheiro')),
    quantidade NUMERIC(10,2),
    valor_dinheiro NUMERIC(10,2),
    observacao TEXT,
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_doacoes_item_id ON doacoes(item_id);
CREATE INDEX IF NOT EXISTS idx_doacoes_criado_em ON doacoes(criado_em DESC);

-- Habilitar RLS (Row Level Security)
ALTER TABLE itens_doacao ENABLE ROW LEVEL SECURITY;
ALTER TABLE doacoes ENABLE ROW LEVEL SECURITY;

-- Política: Todos podem ler
CREATE POLICY "Permitir leitura pública em itens_doacao"
    ON itens_doacao FOR SELECT
    USING (true);

CREATE POLICY "Permitir leitura pública em doacoes"
    ON doacoes FOR SELECT
    USING (true);

-- Política: Todos podem inserir doações
CREATE POLICY "Permitir inserção pública em doacoes"
    ON doacoes FOR INSERT
    WITH CHECK (true);

-- Política: Apenas admin pode deletar (implementado no frontend)
CREATE POLICY "Permitir deleção em doacoes"
    ON doacoes FOR DELETE
    USING (true);

-- Política: Permitir atualização de itens (para cálculos)
CREATE POLICY "Permitir leitura/escrita em itens_doacao"
    ON itens_doacao FOR ALL
    USING (true)
    WITH CHECK (true);

-- ============================================
-- DADOS INICIAIS - 23 ITENS
-- ============================================

INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade) VALUES
(1, 'Arroz (pacotes de 5kg)', 5, 'pacotes'),
(2, 'Coxa e sobrecoxa (cortada em 5 pedaços)', 50, 'kg'),
(3, 'Cebola', 2, 'kg'),
(4, 'Pimentão vermelho grande', 3, 'unidades'),
(5, 'Pimentão amarelo grande', 3, 'unidades'),
(6, 'Lata de milho grande', 2, 'latas'),
(7, 'Lata de selecta grande', 2, 'latas'),
(8, 'Azeitona', 2, 'potes'),
(9, 'Maionese', 2, 'potes'),
(10, 'Vinagre', 1, 'litros'),
(11, 'Requeijão', 2, 'potes'),
(12, 'Shoyu', 1, 'frascos'),
(13, 'Sal', 1, 'kg'),
(14, 'Alho', 0.3, 'kg'),
(15, 'Cebolinha', 2, 'maços'),
(16, 'Colorau', 1, 'pacotes'),
(17, 'Cominho', 1, 'pacotes'),
(18, 'Chimichurri', 1, 'potes'),
(19, 'Orégano', 1, 'potes'),
(20, 'Tomate', 2, 'kg'),
(21, 'Azeite', 1, 'litros'),
(22, 'Carvão', 10, 'kg'),
(23, 'Gelo', 25, 'kg')
ON CONFLICT (id) DO NOTHING;

-- Resetar sequence para continuar do ID 24
SELECT setval('itens_doacao_id_seq', 23, true);

-- ============================================
-- DOAÇÕES INICIAIS PRÉ-CARREGADAS
-- ============================================

INSERT INTO doacoes (item_id, doador_nome, doador_regiao, tipo_doacao, quantidade, valor_dinheiro, observacao) VALUES
-- Denner
(1, 'Denner', NULL, 'item', 5, NULL, NULL),
-- Daniel Alves
(15, 'Daniel Alves', NULL, 'item', 2, NULL, NULL),
(20, 'Daniel Alves', NULL, 'item', 2, NULL, NULL),
-- Dc Lucas
(8, 'Dc Lucas', NULL, 'item', 2, NULL, NULL),
(9, 'Dc Lucas', NULL, 'item', 2, NULL, NULL),
-- Damião
(3, 'Damião', NULL, 'item', 2, NULL, NULL),
(4, 'Damião', NULL, 'item', 3, NULL, NULL),
(5, 'Damião', NULL, 'item', 3, NULL, NULL),
-- Gabriel
(22, 'Gabriel', NULL, 'item', 10, NULL, NULL),
(23, 'Gabriel', NULL, 'item', 25, NULL, NULL);

-- ============================================
-- COMENTÁRIOS FINAIS
-- ============================================
-- Execute este SQL no painel do Supabase (SQL Editor)
-- Após executar, o sistema estará pronto para uso
-- As doações já cadastradas aparecerão automaticamente
