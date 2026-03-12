-- ============================================
-- ATUALIZAR DESCRIÇÕES DOS ITENS
-- Execute este SQL no Supabase para simplificar as descrições
-- ============================================

UPDATE itens_doacao SET descricao = 'Banana (Nanica)' WHERE id = 1;
UPDATE itens_doacao SET descricao = 'Maçã grande' WHERE id = 2;
UPDATE itens_doacao SET descricao = 'Uva sem caroço Thompson/Vitória' WHERE id = 7;
UPDATE itens_doacao SET descricao = 'Morangos' WHERE id = 8;
UPDATE itens_doacao SET descricao = 'Kiwi' WHERE id = 9;
UPDATE itens_doacao SET descricao = 'Maracujá' WHERE id = 10;

-- Verificar as alterações
SELECT id, descricao, quantidade_total, unidade FROM itens_doacao ORDER BY id;
