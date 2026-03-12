# 🤖 GUIA: Bot Telegram com Comandos Interativos

## 📋 Funcionalidades do Bot

Qualquer pessoa poderá usar:
- `/start` ou `/help` - Menu de comandos
- `/status` - Resumo geral (quantos completos, pendentes, doadores, dinheiro)
- `/itens` - Lista completa com barras de progresso
- `/faltam` - Apenas o que ainda falta doar
- `/doar` - Link e instruções para doar

---

## 🚀 Como Instalar (SEM Supabase CLI)

### PASSO 1: Criar a Edge Function no Supabase

1. Acesse: https://supabase.com/dashboard/project/fwmlimudntlrkeukvyjg/functions

2. Clique em **"Create a new function"**

3. Preencha:
   - **Name:** `telegram-bot`
   - **Template:** Escolha "Blank"

4. **Cole o código** do arquivo: `supabase\functions\telegram-bot\index.ts`
   (Todo o conteúdo do arquivo que criei)

5. Clique em **"Deploy function"**

6. Aguarde até aparecer "✓ Deployed"

---

### PASSO 2: Verificar URL da Função

A URL será:
```
https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot
```

Copie essa URL, você vai precisar!

---

### PASSO 3: Configurar Webhook do Telegram

Agora vamos conectar o bot à função:

**Opção A - Via PowerShell (Mais Fácil):**
```powershell
d:\OneDrive\R1\doacoes\configurar-webhook-telegram.ps1
```

**Opção B - Via Navegador:**
1. Acesse no navegador (substitua SEU_TOKEN):
```
https://api.telegram.org/bot8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ/setWebhook?url=https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot
```

2. Você deve ver:
```json
{"ok":true,"result":true,"description":"Webhook was set"}
```

---

### PASSO 4: Testar o Bot

1. Abra o Telegram
2. Procure seu bot: **@doacoesunaadecre_bot**
3. Envie: `/start`
4. Você deve receber o menu de comandos!

**Teste todos os comandos:**
- `/status`
- `/itens`
- `/faltam`
- `/doar`

---

## ✅ Como Compartilhar com Outras Pessoas

### Opção 1: Link Direto
Compartilhe esse link:
```
https://t.me/doacoesunaadecre_bot
```

### Opção 2: Username
Diga para procurarem:
```
@doacoesunaadecre_bot
```

### Opção 3: QR Code
1. Acesse: https://t.me/doacoesunaadecre_bot
2. Clique nos 3 pontinhos
3. "Share bot link"
4. "QR Code"

---

## 📱 Criar Grupo de Notificações (Opcional)

Se quiser que várias pessoas recebam notificações automáticas:

1. Crie um grupo no Telegram
2. Adicione o bot **@doacoesunaadecre_bot** ao grupo
3. Pegue o Chat ID do grupo (negativo, tipo -123456789)
4. Edite `instalar-notificacao-telegram.sql` linha 17:
   ```sql
   chat_id TEXT := '-123456789'; -- ID do grupo
   ```
5. Execute novamente no Supabase SQL Editor

---

## 🐛 Resolução de Problemas

### Bot não responde?
1. Verifique se a função foi deployed:
   https://supabase.com/dashboard/project/fwmlimudntlrkeukvyjg/functions

2. Verifique webhook:
   ```
   https://api.telegram.org/bot8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ/getWebhookInfo
   ```
   Deve mostrar: `"url": "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot"`

3. Veja logs da função:
   **Supabase Dashboard → Functions → telegram-bot → Logs**

### Webhook não configura?
Pode já estar setado para outra URL. Force reset:
```powershell
$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
Invoke-WebRequest "https://api.telegram.org/bot$TOKEN/deleteWebhook"
# Depois configure novamente
```

---

## 🎉 Pronto!

Agora qualquer pessoa pode:
1. Adicionar o bot **@doacoesunaadecre_bot**
2. Usar comandos para ver status
3. Receber notificações de novas doações (se estiver no grupo)
4. Consultar o que falta doar

💡 **Dica:** Compartilhe o bot nos grupos da comunidade!
