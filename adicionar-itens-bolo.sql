-- ============================================
-- ADICIONAR ITENS DO BOLO À LISTA EXISTENTE
-- Mantém todas as doações já registradas!
-- ============================================

-- VERIFICAR ITENS ATUAIS (ANTES)
SELECT id, descricao FROM itens_doacao ORDER BY id;

-- ============================================
-- ADICIONAR NOVOS ITENS
-- ============================================

INSERT INTO itens_doacao (descricao, quantidade_total, unidade) VALUES

-- ITENS PARA O BOLO (8 novos itens)
('🥫 Leite condensado Piracanjuba caixa (R$ 55,00 a R$ 70,00)', 1, 'caixa'),
('🥛 Creme de leite Piracanjuba caixa (R$ 30,00 a R$ 40,00)', 1, 'caixa'),
('🥛 Leite 3 litros (R$ 15,00 a R$ 18,00)', 1, 'unidade'),
('🌾 Trigo 1kg (R$ 6,00 a R$ 10,00)', 1, 'pacote'),
('🥚 Ovos (R$ 12,00 a R$ 16,00)', 1, 'dúzia'),
('🧈 Margarina Qualy 500g (R$ 8,00 a R$ 12,00)', 1, 'unidade'),
('🍰 Chantilly Amélia (R$ 18,00 a R$ 25,00)', 1, 'unidade'),
('🥥 Leite de coco 1L (R$ 8,00 a R$ 12,00)', 1, 'litro'),

-- BASE E DESPENSA (4 novos itens)
('🍚 Arroz 5kg (R$ 25,00 a R$ 35,00)', 4, 'pacotes'),
('🛢️ Óleo de soja (R$ 8,00 a R$ 12,00)', 3, 'unidades'),
('🌾 Farinha de mandioca 5kg (R$ 20,00 a R$ 30,00)', 1, 'pacote'),
('🧈 Margarina grande (R$ 12,00 a R$ 18,00)', 1, 'unidade'),

-- PROTEÍNAS E MOLHOS (8 novos itens)
('🍗 Peito de frango caixa (R$ 80,00 a R$ 120,00)', 2, 'caixas'),
('🥛 Creme de leite 1L (R$ 15,00 a R$ 22,00)', 6, 'unidades'),
('🍅 Ketchup 5L (R$ 35,00 a R$ 50,00)', 1, 'unidade'),
('🌭 Mostarda 5L (R$ 35,00 a R$ 50,00)', 1, 'unidade'),
('🍄 Champignon grande (R$ 12,00 a R$ 18,00)', 2, 'unidades'),
('🌽 Milho verde grande (R$ 8,00 a R$ 12,00)', 2, 'unidades'),
('🫒 Azeitona grande (R$ 15,00 a R$ 25,00)', 2, 'unidades'),
('🥔 Batata palha grande (R$ 18,00 a R$ 28,00)', 4, 'unidades'),

-- HORTIFRÚTI E TEMPEROS (7 novos itens)
('🧂 Tempero Sabor Ami (R$ 8,00 a R$ 12,00)', 1, 'unidade'),
('🧄 Alho descascado (R$ 25,00 a R$ 35,00)', 1.5, 'kg'),
('🧅 Cebola (R$ 4,00 a R$ 6,00)', 3, 'kg'),
('🧅 Cebola roxa (R$ 3,00 a R$ 5,00)', 5, 'unidades'),
('🌶️ Pimentão (R$ 3,00 a R$ 5,00)', 4, 'unidades'),
('🌿 Cebolinha maço (R$ 2,00 a R$ 4,00)', 2, 'maços'),
('🌿 Salsa maço (R$ 2,00 a R$ 4,00)', 2, 'maços'),
('🍌 Banana dedo (R$ 5,00 a R$ 8,00)', 25, 'unidades'),

-- SALADAS E FRUTAS (8 novos itens)
('🥬 Repolho grande (R$ 5,00 a R$ 8,00)', 5, 'unidades'),
('🥬 Alface maço (R$ 3,00 a R$ 5,00)', 6, 'maços'),
('🍅 Tomate (R$ 8,00 a R$ 12,00)', 4, 'kg'),
('🥕 Cenoura (R$ 4,00 a R$ 6,00)', 2, 'kg'),
('🥭 Manga (R$ 3,00 a R$ 6,00)', 5, 'unidades'),
('🍍 Abacaxi (R$ 5,00 a R$ 10,00)', 2, 'unidades');

-- VERIFICAR TODOS OS ITENS (DEPOIS)
SELECT id, descricao, quantidade_total, unidade FROM itens_doacao ORDER BY id;

-- CONTAR TOTAL
SELECT COUNT(*) as total_itens FROM itens_doacao;
