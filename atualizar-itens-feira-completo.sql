-- ============================================
-- ATUALIZAÇÃO FEIRA GASTRONÔMICA COOPHAMIL
-- Com valores e unidades de doação
-- Data: 07/04/2026
-- ============================================

-- 1. ZERAR TODAS AS DOAÇÕES
DELETE FROM doacoes;

-- 2. LIMPAR ITENS ANTIGOS
DELETE FROM itens_doacao;

-- 3. REINICIAR SEQUÊNCIA DE IDs
ALTER SEQUENCE itens_doacao_id_seq RESTART WITH 1;

-- 4. INSERIR NOVOS ITENS COM VALORES E UNIDADES (Ordem Alfabética)
INSERT INTO itens_doacao (id, descricao, quantidade_total, unidade) VALUES
-- FRUTAS (cotas por unidade ou embalagem) - Ordem Alfabética
(1, '🍌 Banana Nanica (R$ 0,80 por unidade)', 30, 'unidades'),
(2, '🥝 Kiwi (R$ 4,00 por unidade)', 12, 'unidades'),
(3, '🍎 Maçã Grande (R$ 2,35 por unidade)', 12, 'unidades'),
(4, '🟠 Mamão Formosa (R$ 8,00 por unidade)', 2, 'unidades'),
(5, '🥭 Manga (R$ 3,00 por unidade)', 4, 'unidades'),
(6, '💜 Maracujá (R$ 3,00 por unidade)', 4, 'unidades'),
(7, '🍈 Melão Amarelo (R$ 9,00 por unidade)', 2, 'unidades'),
(8, '🍓 Morango (R$ 12,00 por bandeja)', 6, 'bandejas'),
(9, '🍇 Uva sem caroço (bandeja 500g - R$ 11,00)', 5, 'bandejas'),

-- INGREDIENTES E KITS - Ordem Alfabética
(10, '🥛 Creme de Leite (R$ 4,50 por caixinha)', 8, 'caixinhas'),
(11, '🥤 Kit Copo Completo (Copo + Tampa + Colher - R$ 1,86)', 50, 'kits'),
(12, '🍼 Leite Condensado (R$ 11,00 por lata)', 8, 'latas'),
(13, '🧃 Suco Maguary concentrado (R$ 11,00 por garrafa)', 2, 'garrafas');

-- 5. ATUALIZAR SEQUÊNCIA
SELECT setval('itens_doacao_id_seq', 13, true);

-- ============================================
-- VERIFICAR RESULTADO
-- ============================================

SELECT 
    id,
    descricao,
    quantidade_total,
    unidade,
    CASE 
        WHEN descricao LIKE '%R$%' THEN 
            CAST(
                SUBSTRING(descricao FROM 'R\$ ([0-9,]+)') 
                AS TEXT
            )
        ELSE 'Sem valor definido'
    END as valor_unitario
FROM itens_doacao
ORDER BY id;

-- ============================================
-- RESUMO POR CATEGORIA
-- ============================================

SELECT 
    CASE 
        WHEN id <= 9 THEN '🍎 Frutas'
        ELSE '🥄 Ingredientes'
    END as categoria,
    COUNT(*) as total_itens
FROM itens_doacao
GROUP BY 
    CASE 
        WHEN id <= 9 THEN '🍎 Frutas'
        ELSE '🥄 Ingredientes'
    END;
