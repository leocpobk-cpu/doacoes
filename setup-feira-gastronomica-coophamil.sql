-- ============================================
-- FEIRA GASTRONÔMICA COOPHAMIL - CONFIGURAÇÃO COMPLETA
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
    data_doacao TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_doacoes_item_id ON doacoes(item_id);
CREATE INDEX idx_doacoes_criado_em ON doacoes(criado_em DESC);
CREATE INDEX idx_doacoes_data_doacao ON doacoes(data_doacao DESC);

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
-- 4. INSERIR ITENS DA FEIRA GASTRONÔMICA
-- ============================================

INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade) VALUES
(1, 'Banana (Nanica)', 30, 'unidades'),
(2, 'Maçã grande', 12, 'unidades'),
(3, 'Mamão Formosa grande', 2, 'unidades'),
(4, 'Melão médio (Amarelo ou Cantaloupe)', 2, 'unidades'),
(5, 'Laranja (para suco base ou gomos)', 20, 'unidades'),
(6, 'Abacaxi grande', 3, 'unidades'),
(7, 'Uva sem caroço Thompson/Vitória', 2.5, 'kg'),
(8, 'Morangos', 6, 'bandejas'),
(9, 'Kiwi', 12, 'unidades'),
(10, 'Maracujá', 4, 'unidades'),
(11, 'Colher descartável', 50, 'unidades'),
(12, 'Copos com tampa 350ml', 50, 'unidades'),
(13, 'Leite condensado', 8, 'latas'),
(14, 'Creme de leite', 8, 'latas'),
(15, 'Suco de maracujá Maguary (concentrado)', 2, 'garrafinhas');

SELECT setval('itens_doacao_id_seq', 15, true);

-- ============================================
-- CONSULTAS ÚTEIS
-- ============================================

-- Ver todos os itens
-- SELECT * FROM itens_doacao ORDER BY id;

-- Ver todas as doações
-- SELECT * FROM doacoes ORDER BY data_doacao DESC;

-- Ver progresso de cada item
-- SELECT 
--     i.id,
--     i.descricao,
--     i.quantidade_total,
--     i.unidade,
--     COALESCE(SUM(d.quantidade), 0) as doado,
--     i.quantidade_total - COALESCE(SUM(d.quantidade), 0) as faltando
-- FROM itens_doacao i
-- LEFT JOIN doacoes d ON d.item_id = i.id
-- GROUP BY i.id, i.descricao, i.quantidade_total, i.unidade
-- ORDER BY i.id;
