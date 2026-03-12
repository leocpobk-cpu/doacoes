-- ============================================
-- SISTEMA DE DOAÇÕES - CONFIGURAÇÃO COMPLETA
-- EXECUTAR TODO ESTE SQL DE UMA VEZ
-- ============================================

-- ============================================
-- 1. LIMPAR TUDO (começar do zero)
-- ============================================

-- Deletar políticas antigas
DROP POLICY IF EXISTS "Permitir leitura pública em itens_doacao" ON itens_doacao;
DROP POLICY IF EXISTS "Permitir leitura pública em doacoes" ON doacoes;
DROP POLICY IF EXISTS "Permitir inserção pública em doacoes" ON doacoes;
DROP POLICY IF EXISTS "Permitir deleção em doacoes" ON doacoes;
DROP POLICY IF EXISTS "Permitir leitura/escrita em itens_doacao" ON itens_doacao;

-- Deletar tabelas antigas
DROP TABLE IF EXISTS doacoes CASCADE;
DROP TABLE IF EXISTS itens_doacao CASCADE;

-- ============================================
-- 2. CRIAR TABELAS
-- ============================================

CREATE TABLE itens_doacao (
    id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    quantidade_total NUMERIC(10,2) NOT NULL,
    unidade TEXT NOT NULL,
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE doacoes (
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

CREATE INDEX idx_doacoes_item_id ON doacoes(item_id);
CREATE INDEX idx_doacoes_criado_em ON doacoes(criado_em DESC);

-- ============================================
-- 3. CONFIGURAR SEGURANÇA (RLS)
-- ============================================

ALTER TABLE itens_doacao ENABLE ROW LEVEL SECURITY;
ALTER TABLE doacoes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Permitir leitura pública em itens_doacao"
    ON itens_doacao FOR SELECT USING (true);

CREATE POLICY "Permitir leitura pública em doacoes"
    ON doacoes FOR SELECT USING (true);

CREATE POLICY "Permitir inserção pública em doacoes"
    ON doacoes FOR INSERT WITH CHECK (true);

CREATE POLICY "Permitir deleção em doacoes"
    ON doacoes FOR DELETE USING (true);

CREATE POLICY "Permitir leitura/escrita em itens_doacao"
    ON itens_doacao FOR ALL USING (true) WITH CHECK (true);

-- ============================================
-- 4. INSERIR 23 ITENS (ordem alfabética)
-- ============================================

INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade) VALUES
(1, 'Alface (pé)', 10, 'unidades'),
(2, 'Alhos', 1, 'kg'),
(3, 'Arroz', 5, 'pacotes de 5kg'),
(4, 'Bandeja de isopor (Para comida)', 300, 'unidades'),
(5, 'Calabresa', 1, 'pacote'),
(6, 'Cebola', 2, 'kg'),
(7, 'Cebolinha', 4, 'maços'),
(8, 'Cenoura', 10, 'kg'),
(9, 'Couve', 10, 'maços'),
(10, 'Coxa e sobrecoxa (cortada em 5 pedaços)', 50, 'kg'),
(11, 'Farinha de mandioca', 10, 'kg'),
(12, 'Garfo', 300, 'unidades'),
(13, 'Latas grandes de milho', 2, 'latas'),
(14, 'Latas grandes de seleta de legumes', 2, 'latas'),
(15, 'Margarina', 1, 'kg'),
(16, 'Óleo', 10, 'latas'),
(17, 'Pimentão amarelo grande', 3, 'unidades'),
(18, 'Pimentão vermelho grande', 3, 'unidades'),
(19, 'Refrigerante (fardo)', 7, 'fardos'),
(20, 'Repolho Grande', 4, 'unidades'),
(21, 'Sal', 1, 'pacote'),
(22, 'Salsa', 4, 'maços'),
(23, 'Tomate', 2, 'kg');

SELECT setval('itens_doacao_id_seq', 23, true);

-- ============================================
-- 5. INSERIR DOAÇÕES JÁ REALIZADAS
-- ============================================

INSERT INTO doacoes (item_id, doador_nome, doador_regiao, tipo_doacao, quantidade, valor_dinheiro) VALUES
-- Denner R13
(3, 'Denner', 'R13', 'item', 2, NULL),      -- Arroz 2 pacotes
(10, 'Denner', 'R13', 'item', 10, NULL),    -- Coxa e sobrecoxa 10kg
-- Daniel Alves R09
(2, 'Daniel Alves', 'R09', 'item', 1, NULL),   -- Alhos 1kg
(21, 'Daniel Alves', 'R09', 'item', 1, NULL),  -- Sal 1 pacote
(15, 'Daniel Alves', 'R09', 'item', 1, NULL),  -- Margarina 1kg
-- Dc Lucas Figueiral
(8, 'Dc Lucas', 'Figueiral', 'item', 10, NULL),  -- Cenoura 10kg
(11, 'Dc Lucas', 'Figueiral', 'item', 10, NULL), -- Farinha 10kg
(9, 'Dc Lucas', 'Figueiral', 'item', 10, NULL),  -- Couve 10 maços
-- Damião R13
(4, 'Damião', 'R13', 'item', 100, NULL),  -- Bandeja 100 unidades
-- Gabriel R04
(19, 'Gabriel', 'R04', 'dinheiro', NULL, 40.00); -- Refrigerante R$ 40

-- ============================================
-- 6. VERIFICAÇÃO FINAL
-- ============================================

SELECT '✅ SUCESSO! Sistema configurado!' as status,
       (SELECT COUNT(*) FROM itens_doacao) as total_itens,
       (SELECT COUNT(*) FROM doacoes) as total_doacoes;
