-- ============================================
-- ATUALIZAÇÃO FEIRA GASTRONÔMICA COOPHAMIL
-- Data: 07/04/2026
-- ============================================

-- 1. ZERAR TODAS AS DOAÇÕES
DELETE FROM doacoes;

-- 2. ALTERAR LARANJA PARA MANGA
UPDATE itens_doacao 
SET 
    descricao = 'Manga grande',
    quantidade_total = 4,
    unidade = 'unidades'
WHERE id = 5;

-- 3. REMOVER ABACAXI
DELETE FROM itens_doacao WHERE id = 6;

-- 4. REORGANIZAR IDs (opcional - para manter sequência)
-- Isso vai renumerar os itens após a remoção
UPDATE itens_doacao SET id = id - 1 WHERE id > 6;

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
