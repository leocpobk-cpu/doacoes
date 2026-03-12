-- ============================================
-- ADICIONAR PREÇOS UNITÁRIOS AOS ITENS
-- ============================================

-- 1. Adicionar coluna de preço unitário
ALTER TABLE itens_doacao ADD COLUMN IF NOT EXISTS valor_unitario NUMERIC(10,2);

-- 2. Definir preços de cada item (ajuste conforme necessário)
UPDATE itens_doacao SET valor_unitario = 
    CASE id
        WHEN 1 THEN 3.00    -- Alface (pé) - R$ 3 por pé
        WHEN 2 THEN 15.00   -- Alhos - R$ 15 por kg
        WHEN 3 THEN 18.00   -- Arroz - R$ 18 por pacote de 5kg
        WHEN 4 THEN 0.50    -- Bandeja de isopor - R$ 0,50 por unidade
        WHEN 5 THEN 25.00   -- Calabresa - R$ 25 por pacote
        WHEN 6 THEN 5.00    -- Cebola - R$ 5 por kg
        WHEN 7 THEN 2.00    -- Cebolinha - R$ 2 por maço
        WHEN 8 THEN 3.00    -- Cenoura - R$ 3 por kg
        WHEN 9 THEN 2.00    -- Couve - R$ 2 por maço
        WHEN 10 THEN 18.00  -- Coxa e sobrecoxa - R$ 18 por kg
        WHEN 11 THEN 8.00   -- Farinha de mandioca - R$ 8 por kg
        WHEN 12 THEN 0.15   -- Garfo - R$ 0,15 por unidade
        WHEN 13 THEN 6.00   -- Latas grandes de milho - R$ 6 por lata
        WHEN 14 THEN 6.00   -- Latas grandes de seleta - R$ 6 por lata
        WHEN 15 THEN 12.00  -- Margarina - R$ 12 por kg
        WHEN 16 THEN 8.00   -- Óleo - R$ 8 por lata
        WHEN 17 THEN 4.00   -- Pimentão amarelo - R$ 4 por unidade
        WHEN 18 THEN 4.00   -- Pimentão vermelho - R$ 4 por unidade
        WHEN 19 THEN 30.00  -- Refrigerante (fardo) - R$ 30 por fardo
        WHEN 20 THEN 6.00   -- Repolho Grande - R$ 6 por unidade
        WHEN 21 THEN 3.00   -- Sal - R$ 3 por pacote
        WHEN 22 THEN 2.00   -- Salsa - R$ 2 por maço
        WHEN 23 THEN 6.00   -- Tomate - R$ 6 por kg
    END;

-- 3. Verificar se aplicou corretamente
SELECT id, descricao, valor_unitario, unidade 
FROM itens_doacao 
ORDER BY id;
