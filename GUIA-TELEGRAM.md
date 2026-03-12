# 🤖 Guia de Configuração - Notificações Telegram

## 📋 Pré-requisitos

1. ✅ Conta no Supabase (já tem)
2. ✅ Conta no Telegram
3. ✅ Supabase CLI instalado

---

## 🔧 PASSO 1: Instalar Supabase CLI

Abra o PowerShell e execute:

```powershell
# Instalar via Scoop (recomendado)
scoop install supabase

# OU via npm (se tiver Node.js)
npm install -g supabase
```

Verifique a instalação:
```powershell
supabase --version
```

---

## 🤖 PASSO 2: Criar Bot no Telegram

1. Abra o Telegram
2. Procure por **@BotFather**
3. Envie: `/newbot`
4. Nome do bot: `Doações UMAAD`
5. Username: `doacoes_umaad_bot` (ou outro disponível)
6. **COPIE O TOKEN** que o BotFather fornecer
   - Formato: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`

---

## 💬 PASSO 3: Pegar seu Chat ID

1. Procure por **@userinfobot** no Telegram
2. Envie qualquer mensagem
3. **COPIE O ID** que ele responder (número como `123456789`)

**OU** envie uma mensagem para seu bot e acesse:
```
https://api.telegram.org/bot<SEU_TOKEN>/getUpdates
```
Procure por `"chat":{"id":123456789}`

---

## 🚀 PASSO 4: Fazer Login no Supabase CLI

No PowerShell, navegue até a pasta do projeto:

```powershell
cd d:\OneDrive\R1\doacoes
supabase login
```

Isso abrirá o navegador para você autorizar.

---

## 🔐 PASSO 5: Vincular ao Projeto

```powershell
supabase link --project-ref fwmlimudntlrkeukvyjg
```

---

## 🌐 PASSO 6: Configurar Variáveis de Ambiente

No **Supabase Dashboard**:

1. Acesse: https://supabase.com/dashboard/project/fwmlimudntlrkeukvyjg
2. Vá em **Settings** → **Edge Functions**
3. Clique em **Add Secret**
4. Adicione:

**Secret 1:**
- Name: `TELEGRAM_BOT_TOKEN`
- Value: (cole o token do BotFather)

**Secret 2:**
- Name: `TELEGRAM_CHAT_ID`
- Value: (cole seu chat ID)

---

## 📤 PASSO 7: Deploy da Edge Function

No PowerShell:

```powershell
cd d:\OneDrive\R1\doacoes
supabase functions deploy notificar-telegram --no-verify-jwt
```

Aguarde a mensagem: `✅ Function deployed successfully`

---

## 🗄️ PASSO 8: Criar Trigger no Banco

1. Acesse o **SQL Editor** no Supabase:
   - https://supabase.com/dashboard/project/fwmlimudntlrkeukvyjg/editor

2. Copie TODO o conteúdo do arquivo `telegram-webhook.sql`

3. Cole no SQL Editor

4. Clique em **Run**

---

## ✅ PASSO 9: Testar

1. Abra seu sistema de doações: http://localhost/index-supabase.html
2. Faça uma doação de teste
3. **Você deve receber uma mensagem no Telegram em segundos!**

Mensagem esperada:
```
🎁 NOVA DOAÇÃO!

👤 Doador: Seu Nome (R1)
📦 Item: Arroz 5 pacotes de 5kg
💰 Valor: R$ 18.00
📊 Equivale a: 1 pacotes de 5kg

⏰ 19/02/2026 14:30:45
```

---

## 🐛 Resolução de Problemas

### Erro: "Function not found"
```powershell
supabase functions list
```
Verifique se `notificar-telegram` aparece na lista.

### Não recebe notificação?
1. Verifique os logs da função:
```powershell
supabase functions logs notificar-telegram
```

2. Teste manualmente:
```powershell
curl -X POST https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/notificar-telegram \
  -H "Authorization: Bearer SEU_ANON_KEY" \
  -d '{"type":"INSERT","table":"doacoes","record":{"doador_nome":"Teste"}}'
```

### Erro de permissão no trigger?
Verifique se a extensão `http` está habilitada:
```sql
CREATE EXTENSION IF NOT EXISTS http;
```

---

## 📊 BÔNUS: Exportar Planilha

Quer receber também uma planilha Excel/CSV? Posso adicionar:

1. **Comando no bot** (`/relatorio`)
2. **Envio automático diário** (todo dia às 18h)
3. **Botão no site** ("Enviar resumo para admin")

Me avise se quiser implementar!

---

## 🔄 Próximos Passos

Após confirmar que funciona, posso adicionar:

- 📊 Gráfico de progresso das doações
- 🎯 Meta diária com porcentagem
- 👥 Ranking de doadores
- 📅 Resumo semanal automático

Bora testar? 🚀
