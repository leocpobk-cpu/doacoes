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

-- 4. INSERIR NOVOS ITENS (Organizados por categoria)
INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade) VALUES
-- PROTEÍNAS E CARNES
(1, '🍗 Caixa de coxa e sobrecoxa', 3, 'caixas'),

-- GRÃOS E CEREAIS
(2, '🍚 Arroz (pacote de 5kg)', 3, 'pacotes'),
(3, '🥖 Farinha de mandioca', 5, 'kg'),

-- TEMPEROS E CONDIMENTOS
(4, '🧄 Alho descascado', 1.5, 'kg'),
(5, '🫚 Tempero sabor Amil', 1, 'unidade'),
(6, '🌶️ Colorau pequeno', 2, 'unidades'),
(7, '🫒 Azeitona grande', 2, 'latas'),

-- LEGUMES E VERDURAS PARA O PREPARO
(8, '🧅 Cebola', 3, 'kg'),
(9, '🫑 Pimentão', 4, 'unidades'),
(10, '🌽 Milho verde grande', 2, 'latas'),
(11, '🌿 Cebolinha', 2, 'maços'),
(12, '🌿 Salsa', 2, 'maços'),

-- SALADA
(13, '🥬 Repolho grande', 5, 'unidades'),
(14, '🥗 Alface', 6, 'pés'),
(15, '🍅 Tomate', 4, 'kg'),
(16, '🥕 Cenoura', 2, 'kg'),
(17, '🧅 Cebola Roxa', 5, 'unidades'),

-- FRUTAS
(18, '🥭 Manga', 5, 'unidades'),
(19, '🍍 Abacaxi', 2, 'unidades'),
(20, '🍌 Dedo de banana', 25, 'unidades'),

-- INGREDIENTES DIVERSOS
(21, '🛢️ Óleo de soja', 8, 'unidades'),
(22, '🧈 Margarina grande', 1, 'unidade');

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
