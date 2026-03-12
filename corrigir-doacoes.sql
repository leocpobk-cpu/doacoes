-- ============================================
-- CORREÇÃO COMPLETA - ITENS E DOAÇÕES
-- ============================================
-- Execute este SQL para atualizar tudo

-- 1. Limpar doações e itens existentes
DELETE FROM doacoes;
DELETE FROM itens_doacao;

-- 2. Inserir os 23 itens corretos
INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade) VALUES
(1, 'Arroz', 5, 'pacotes de 5kg'),
(2, 'Coxa e sobrecoxa (cortada em 5 pedaços)', 50, 'kg'),
(3, 'Cebola', 2, 'kg'),
(4, 'Pimentão vermelho grande', 3, 'unidades'),
(5, 'Pimentão amarelo grande', 3, 'unidades'),
(6, 'Latas grandes de milho', 2, 'latas'),
(7, 'Latas grandes de seleta de legumes', 2, 'latas'),
(8, 'Alhos', 1, 'kg'),
(9, 'Óleo', 10, 'latas'),
(10, 'Tomate', 2, 'kg'),
(11, 'Sal', 1, 'pacote'),
(12, 'Cebolinha', 4, 'maços'),
(13, 'Salsa', 4, 'maços'),
(14, 'Cenoura', 10, 'kg'),
(15, 'Farinha de mandioca', 10, 'kg'),
(16, 'Couve', 10, 'maços'),
(17, 'Margarina', 1, 'kg'),
(18, 'Calabresa', 1, 'pacote'),
(19, 'Repolho Grande', 4, 'unidades'),
(20, 'Alface (pé)', 10, 'unidades'),
(21, 'Bandeja de isopor (Para comida)', 300, 'unidades'),
(22, 'Garfo', 300, 'unidades'),
(23, 'Refrigerante (fardo)', 7, 'fardos');

-- Resetar sequence
SELECT setval('itens_doacao_id_seq', 23, true);

-- 3. Inserir as doações conforme lista
INSERT INTO doacoes (item_id, doador_nome, doador_regiao, tipo_doacao, quantidade, valor_dinheiro, observacao) VALUES
-- Denner R13
(1, 'Denner', 'R13', 'item', 2, NULL, NULL),  -- Arroz 2 pacotes
(2, 'Denner', 'R13', 'item', 10, NULL, NULL), -- Coxa e sobrecoxa 10kg
-- Daniel Alves R9
(8, 'Daniel Alves', 'R09', 'item', 1, NULL, NULL),  -- Alho 1kg
(11, 'Daniel Alves', 'R09', 'item', 1, NULL, NULL), -- Sal 1 pacote
(17, 'Daniel Alves', 'R09', 'item', 1, NULL, NULL), -- Margarina 1kg
-- Dc Lucas Figueiral
(14, 'Dc Lucas', 'Figueiral', 'item', 10, NULL, NULL), -- Cenoura 10kg
(15, 'Dc Lucas', 'Figueiral', 'item', 10, NULL, NULL), -- Farinha 10kg
(16, 'Dc Lucas', 'Figueiral', 'item', 10, NULL, NULL), -- Couve 10 maços
-- Damião R13
(21, 'Damião', 'R13', 'item', 100, NULL, NULL), -- Bandeja 100 unidades
-- Gabriel R4
(23, 'Gabriel', 'R04', 'dinheiro', NULL, 40.00, NULL); -- Refrigerante R$ 40

-- ============================================
-- Confirme que está correto
-- ============================================
SELECT 'Itens e doações corrigidos!' as status;
