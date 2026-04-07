-- ============================================
-- VERSÃO ALTERNATIVA: Valores em coluna separada
-- (Requer adicionar campo 'valor_unitario' na tabela)
-- ============================================

-- OPÇÃO 1: Adicionar coluna de valor (se não existir)
ALTER TABLE itens_doacao 
ADD COLUMN IF NOT EXISTS valor_unitario DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS divisao_doacao TEXT;

-- 1. ZERAR TODAS AS DOAÇÕES
DELETE FROM doacoes;

-- 2. LIMPAR ITENS ANTIGOS
DELETE FROM itens_doacao;

-- 3. REINICIAR SEQUÊNCIA
ALTER SEQUENCE itens_doacao_id_seq RESTART WITH 1;

-- 4. INSERIR ITENS COM VALORES SEPARADOS (Ordem Alfabética)
INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade, valor_unitario, divisao_doacao) VALUES
-- FRUTAS - Ordem Alfabética
(1, '🍌 Banana Nanica', 30, 'unidades', 0.80, '1 unidade'),
(2, '🥝 Kiwi', 12, 'unidades', 4.00, '1 unidade'),
(3, '🍎 Maçã Grande', 12, 'unidades', 2.35, '1 unidade'),
(4, '🟠 Mamão Formosa', 2, 'unidades', 8.00, '1 unidade'),
(5, '🥭 Manga', 4, 'unidades', 3.00, '1 unidade'),
(6, '💜 Maracujá', 4, 'unidades', 3.00, '1 unidade'),
(7, '🍈 Melão Amarelo', 2, 'unidades', 9.00, '1 unidade'),
(8, '🍓 Morango', 6, 'bandejas', 12.00, '1 bandeja'),
(9, '🍇 Uva sem caroço', 5, 'bandejas', 11.00, '1 bandeja (500g)'),

-- INGREDIENTES - Ordem Alfabética
(10, '🥛 Creme de Leite', 8, 'caixinhas', 4.50, '1 caixinha'),
(11, '🥤 Kit Copo Completo (Copo + Tampa + Colher)', 50, 'kits', 1.86, '1 kit completo'),
(12, '🍼 Leite Condensado', 8, 'latas', 11.00, '1 lata'),
(13, '🧃 Suco Maguary concentrado', 2, 'garrafas', 11.00, '1 garrafa');

-- 5. ATUALIZAR SEQUÊNCIA
SELECT setval('itens_doacao_id_seq', 13, true);

-- VERIFICAR
SELECT 
    id,
    descricao,
    quantidade_total,
    unidade,
    CONCAT('R$ ', CAST(valor_unitario AS TEXT)) as valor,
    divisao_doacao as "divisão para doação"
FROM itens_doacao
ORDER BY id;
