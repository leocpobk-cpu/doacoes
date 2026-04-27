-- ============================================
-- REATIVAR SISTEMA COM LISTA ATUALIZADA
-- ============================================

-- 1. LIMPAR ITENS E DOAÇÕES ANTIGAS
DELETE FROM doacoes;
DELETE FROM itens_doacao;

-- 2. RESETAR SEQUÊNCIAS
ALTER SEQUENCE itens_doacao_id_seq RESTART WITH 1;
ALTER SEQUENCE doacoes_id_seq RESTART WITH 1;

-- 3. INSERIR NOVOS ITENS (SEM VALORES DE REFERÊNCIA)

-- BASE E DESPENSA (4 itens)
INSERT INTO itens_doacao (descricao, quantidade_total, unidade) VALUES
('🍚 Arroz 5kg', 4, 'pacotes'),
('🛢️ Óleo de soja', 3, 'unidades'),
('🌾 Farinha de mandioca', 5, 'kg'),
('🧈 Margarina grande', 1, 'unidade'),

-- PROTEÍNAS E MOLHOS (8 itens)
('🍗 Peito de frango caixa', 2, 'caixas'),
('🥛 Creme de leite 1L', 6, 'unidades'),
('🍅 Ketchup 5L', 1, 'unidade'),
('🌭 Mostarda 5L', 1, 'unidade'),
('🍄 Champignon grande', 2, 'unidades'),
('🌽 Milho verde grande', 2, 'unidades'),
('🫒 Azeitona grande', 2, 'unidades'),
('🥔 Batata palha grande', 4, 'unidades'),

-- HORTIFRÚTI E TEMPEROS (8 itens)
('🧂 Tempero Sabor Ami', 1, 'unidade'),
('🧄 Alho descascado', 1.5, 'kg'),
('🧅 Cebola', 3, 'kg'),
('🧅 Cebola roxa', 5, 'unidades'),
('🌶️ Pimentão', 4, 'unidades'),
('🌿 Cebolinha', 2, 'maços'),
('🌿 Salsa', 2, 'maços'),
('🍌 Banana dedo', 25, 'unidades'),

-- SALADAS (6 itens)
('🥬 Repolho grande', 5, 'unidades'),
('🥬 Alface', 6, 'maços'),
('🍅 Tomate', 4, 'kg'),
('🥕 Cenoura', 2, 'kg'),
('🥭 Manga', 5, 'unidades'),
('🍍 Abacaxi', 2, 'unidades'),

-- ITENS PARA O BOLO (8 itens)
('🥫 Leite condensado Piracanjuba caixa', 1, 'caixa'),
('🥛 Creme de leite Piracanjuba caixa', 1, 'caixa'),
('🥛 Leite', 3, 'litros'),
('🌾 Farinha de trigo', 1, 'kg'),
('🥚 Ovos', 1, 'dúzia'),
('🧈 Margarina Qualy 500g', 1, 'unidade'),
('🍰 Chantilly Amélia', 1, 'unidade'),
('🥥 Leite de coco 1L', 1, 'litro');

-- 4. REGISTRAR DOAÇÕES JÁ REALIZADAS

-- Arroz - Leonardo (1 pacote)
INSERT INTO doacoes (item_id, doador_nome, tipo_doacao, quantidade, valor_dinheiro, observacao) 
VALUES (1, 'Leonardo', 'item', 1, NULL, NULL);

-- Óleo de soja - Thais (2 óleos)
INSERT INTO doacoes (item_id, doador_nome, tipo_doacao, quantidade, valor_dinheiro, observacao) 
VALUES (2, 'Thais', 'item', 2, NULL, NULL);

-- Margarina grande - Alzira
INSERT INTO doacoes (item_id, doador_nome, tipo_doacao, quantidade, valor_dinheiro, observacao) 
VALUES (4, 'Alzira', 'item', 1, NULL, NULL);

-- Peito de frango - Manoel (1 caixa)
INSERT INTO doacoes (item_id, doador_nome, tipo_doacao, quantidade, valor_dinheiro, observacao) 
VALUES (5, 'Manoel', 'item', 1, NULL, NULL);

-- Cebola Roxa - Irmã Keila (PIX)
INSERT INTO doacoes (item_id, doador_nome, tipo_doacao, quantidade, valor_dinheiro, observacao) 
VALUES (16, 'Irmã Keila', 'item', 5, NULL, 'Doação em pix');

-- Pimentão - Irmã Keila (PIX)
INSERT INTO doacoes (item_id, doador_nome, tipo_doacao, quantidade, valor_dinheiro, observacao) 
VALUES (17, 'Irmã Keila', 'item', 4, NULL, 'Doação em pix');

-- Alface - Irmã Juliana (4 pés)
INSERT INTO doacoes (item_id, doador_nome, tipo_doacao, quantidade, valor_dinheiro, observacao) 
VALUES (22, 'Irmã Juliana', 'item', 4, NULL, NULL);

-- 5. VERIFICAR RESULTADO
SELECT 
    i.id,
    i.descricao,
    i.quantidade_total,
    COALESCE(SUM(d.quantidade), 0) as doado,
    i.quantidade_total - COALESCE(SUM(d.quantidade), 0) as falta
FROM itens_doacao i
LEFT JOIN doacoes d ON i.id = d.item_id
GROUP BY i.id, i.descricao, i.quantidade_total
ORDER BY i.id;

-- CONTAR DOAÇÕES
SELECT COUNT(*) as total_doacoes FROM doacoes;
