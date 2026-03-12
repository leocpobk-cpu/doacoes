# 🍓 Feira Gastronômica COOPHAMIL - Sistema de Doações

Sistema online para controlar doações de frutas e ingredientes para a Feira Gastronômica do COOPHAMIL.

## 📋 Itens Necessários

### 🍎 Frutas
| Fruta | Quantidade | Observações |
|-------|-----------|-------------|
| Banana (Nanica) | 2-3 dúzias (30 unid.) | Picar por último para não escurecer |
| Maçã grande | 10-12 unidades | Deixar em água com limão para não oxidar |
| Mamão Formosa grande | 2 unidades | Mais firme para picar em cubos |
| Melão médio | 2 unidades | Amarelo ou Cantaloupe |
| Laranja | 15-20 unidades | Para suco base ou gomos sem pele |
| Abacaxi grande | 3 unidades | Ajuda na conservação |
| Uva sem caroço | 4-5 caixinhas (2.5 kg) | Thompson ou Vitória |
| Morangos | 5-6 bandejas | Colocar por cima ou no final |
| Kiwi | 10-12 unidades | Contraste visual verde |
| Maracujá | 4 unidades | Sementes dão crocância |

### 🥄 Descartáveis e Ingredientes
- 50 colheres descartáveis
- 50 copos com tampa 350ml
- 8 latas de leite condensado
- 8 latas de creme de leite
- 2 garrafinhas de suco de maracujá Maguary (concentrado)

## 💰 Como Doar

### 🌐 Sistema Online
Acesse: https://leocpobk-cpu.github.io/doacoes/

### 💵 Doação em Dinheiro
**PIX:** leocpo@gmail.com  
**Favorecido:** Leonardo Cezario Pinto de Oliveira

### 📦 Doação de Itens
1. Acesse o sistema online
2. Escolha o item que deseja doar
3. Informe seu nome e quantidade
4. Registre a doação

## 🤖 Bot do Telegram

Configure o bot para receber notificações em tempo real das doações:

### Comandos Disponíveis:
- `/start` ou `/help` - Ver todos os comandos
- `/status` - Resumo geral das doações
- `/itens` - Lista completa com progresso
- `/faltam` - Apenas itens pendentes
- `/ultimas` - Últimas 5 doações registradas
- `/doar` - Informações de como doar

## 🚀 Configuração Técnica

### Pré-requisitos
- Conta no Supabase
- Token do Bot Telegram

### 1. Configurar Banco de Dados

Execute o SQL no Supabase:
```bash
# Execute o arquivo SQL no Supabase SQL Editor
setup-feira-gastronomica-coophamil.sql
```

### 2. Deploy do Bot Telegram

```bash
# Fazer deploy da função
supabase functions deploy telegram-bot

# Configurar variáveis de ambiente no Supabase:
# - TELEGRAM_BOT_TOKEN
# - SUPABASE_URL
# - SUPABASE_ANON_KEY
```

### 3. Configurar Webhook

Execute o script PowerShell:
```powershell
.\configurar-webhook-telegram.ps1
```

### 4. Publicar Interface Web

A interface está em: `docs/index-supabase.html`

Configure o GitHub Pages apontando para a pasta `docs/`.

## 📁 Estrutura do Projeto

```
doacoes/
├── docs/
│   └── index-supabase.html          # Interface web principal
├── supabase/
│   └── functions/
│       └── telegram-bot/
│           └── index.ts              # Bot do Telegram
├── setup-feira-gastronomica-coophamil.sql  # SQL inicial
├── configurar-webhook-telegram.ps1   # Script de setup
└── README-FEIRA-GASTRONOMICA.md     # Este arquivo
```

## 🔧 Manutenção

### Adicionar Novos Itens
Execute SQL no Supabase:
```sql
INSERT INTO itens_doacao (descricao, quantidade_total, unidade) 
VALUES ('Nome do Item', 10, 'unidades');
```

### Visualizar Doações
```sql
SELECT 
    i.descricao,
    i.quantidade_total,
    COALESCE(SUM(d.quantidade), 0) as doado,
    i.quantidade_total - COALESCE(SUM(d.quantidade), 0) as faltando
FROM itens_doacao i
LEFT JOIN doacoes d ON d.item_id = i.id
GROUP BY i.id, i.descricao, i.quantidade_total
ORDER BY i.id;
```

## 📞 Suporte

Para dúvidas ou problemas:
- **PIX:** leocpo@gmail.com (Leonardo Cezario Pinto de Oliveira)

---

**Desenvolvido para a Feira Gastronômica COOPHAMIL 2026** 🍓
