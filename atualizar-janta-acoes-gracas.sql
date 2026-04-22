-- ============================================
-- JANTA DO CULTO DE AÇÕES DE GRAÇAS
-- Pastor Jonatas
-- Data: 22/04/2026
-- ============================================

-- 1. ZERAR TODAS AS DOAÇÕES
DELETE FROM doacoes;

-- 2. LIMPAR ITENS ANTIGOS
DELETE FROM itens_doacao;

-- 3. REINICIAR SEQUÊNCIA DE IDs
ALTER SEQUENCE itens_doacao_id_seq RESTART WITH 1;

-- 4. INSERIR NOVOS ITENS COM VALORES DE REFERÊNCIA (Organizados por categoria)
INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade) VALUES
-- PROTEÍNAS E CARNES
(1, '🍗 Caixa de coxa e sobrecoxa 15kg (R$ 110,00 a R$ 135,00)', 3, 'caixas'),

-- GRÃOS E CEREAIS
(2, '🍚 Arroz pacote de 5kg (R$ 28,00 a R$ 35,00)', 3, 'pacotes'),
(3, '🥖 Farinha de mandioca (R$ 6,00 a R$ 10,00 por kg)', 5, 'kg'),

-- TEMPEROS E CONDIMENTOS
(4, '🧄 Alho descascado pacote 500g (R$ 16,00 a R$ 22,00)', 1.5, 'kg'),
(5, '🫚 Tempero Sabor Ami pote 1kg (R$ 16,00 a R$ 21,00)', 1, 'unidade'),
(6, '🌶️ Colorau pequeno 100g (R$ 2,00 a R$ 3,50)', 2, 'unidades'),
(7, '🫒 Azeitona grande 500g (R$ 15,00 a R$ 22,00)', 2, 'latas'),

-- LEGUMES E VERDURAS PARA O PREPARO
(8, '🧅 Cebola (R$ 5,00 a R$ 7,00 por kg)', 3, 'kg'),
(9, '🫑 Pimentão verde (R$ 1,50 a R$ 2,50 por unidade)', 4, 'unidades'),
(10, '🌽 Milho verde grande 1kg-1,7kg (R$ 14,00 a R$ 18,00)', 2, 'latas'),
(11, '🌿 Cebolinha maço (R$ 2,50 a R$ 3,50)', 2, 'maços'),
(12, '🌿 Salsa maço (R$ 2,50 a R$ 3,50)', 2, 'maços'),

-- SALADA
(13, '🥬 Repolho verde grande (R$ 4,00 a R$ 6,00 por unidade)', 5, 'unidades'),
(14, '🥗 Alface pé (R$ 3,00 a R$ 4,50 por pé)', 6, 'pés'),
(15, '🍅 Tomate (R$ 6,00 a R$ 9,00 por kg)', 4, 'kg'),
(16, '🥕 Cenoura (R$ 4,50 a R$ 6,50 por kg)', 2, 'kg'),
(17, '🧅 Cebola Roxa (R$ 1,00 a R$ 1,50 por unidade)', 5, 'unidades'),

-- FRUTAS
(18, '🥭 Manga Palmer/Tommy (R$ 2,50 a R$ 4,00 por unidade)', 5, 'unidades'),
(19, '🍍 Abacaxi (R$ 6,00 a R$ 10,00 por unidade)', 2, 'unidades'),
(20, '🍌 Banana da terra dedo (R$ 1,50 a R$ 2,50 por dedo)', 25, 'unidades'),

-- INGREDIENTES DIVERSOS
(21, '🛢️ Óleo de soja 900ml (R$ 5,50 a R$ 6,50)', 8, 'unidades'),
(22, '🧈 Margarina grande 1kg (R$ 15,00 a R$ 19,00)', 1, 'unidade');

-- 5. ATUALIZAR SEQUÊNCIA
SELECT setval('itens_doacao_id_seq', 22, true);

-- ============================================
-- VERIFICAR RESULTADO
-- ============================================
SELECT 
    id,
    descricao,
    quantidade_total,
    unidade
FROM itens_doacao
ORDER BY id;
