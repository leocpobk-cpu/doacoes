# 🔍 Verificar Projeto no Supabase

## Situação Atual
Você tem **1 projeto** na organização JEAD, mas esperava ver 2 projetos.

---

## 🎯 Opção 1: Verificar se JEAD é o projeto das doações

### Passo 1: Clique no projeto "JEAD"
1. Na tela de organizações, clique no card **"JEAD"**
2. Isso vai abrir o dashboard do projeto

### Passo 2: Verifique se tem as tabelas de doação
1. No menu lateral, clique em: **Table Editor** (ícone de tabela)
2. Procure por estas tabelas:
   - `itens_doacao`
   - `doacoes`

### ✅ Se encontrou as tabelas:
**Este é o projeto correto!** Siga para o SQL Editor:
1. Menu lateral → **SQL Editor**
2. Clique em **+ New query**
3. Cole o conteúdo de `setup-feira-gastronomica-coophamil.sql`
4. Clique em **Run**

### ❌ Se NÃO encontrou as tabelas:
Vá para a **Opção 2** abaixo.

---

## 🆕 Opção 2: Criar um novo projeto para as doações

### Passo 1: Criar o projeto
1. Volte para: https://supabase.com/dashboard/organizations
2. Clique no botão **+ New project** (canto superior direito)
3. Preencha:
   - **Name:** Doações COOPHAMIL (ou nome que preferir)
   - **Database Password:** Crie uma senha forte e SALVE!
   - **Region:** South America (São Paulo) - mais próximo do Brasil
   - **Pricing Plan:** Free (suficiente para este projeto)
4. Clique em **Create new project**
5. Aguarde ~2 minutos (criação do banco de dados)

### Passo 2: Executar o SQL
Após o projeto ser criado:
1. Menu lateral → **SQL Editor**
2. Clique em **+ New query**
3. Cole TODO o conteúdo de: `setup-feira-gastronomica-coophamil.sql`
4. Clique em **Run**

---

## 🔄 Opção 3: O projeto pode estar em outra conta/organização

### Verifique se tem múltiplas contas:
1. Clique no **ícone do seu perfil** (canto superior direito)
2. Veja se há opção de trocar de organização
3. Se tiver, troque e procure o outro projeto

---

## 📝 Qual opção seguir?

**Recomendação:**
1. Primeiro, verifique se **JEAD** já tem as tabelas (Opção 1)
2. Se não tiver, **crie um novo projeto** (Opção 2)
3. Se você tinha outro projeto antes, verifique outras organizações (Opção 3)

---

## ⚠️ Importante: Anotar informações do projeto

Após identificar ou criar o projeto, anote:

### Informações necessárias:
1. **Project URL** (exemplo: https://xxxxx.supabase.co)
2. **Anon/Public Key** (em Settings → API)
3. **Service Role Key** (em Settings → API) - MANTENHA SECRETO!

### Onde encontrar:
- Menu lateral → **Settings** (ícone de engrenagem)
- Clique em → **API**
- Copie:
  - **Project URL**
  - **anon public** (chave pública)

---

## 🤖 Próximos passos após executar o SQL:

1. ✅ Verify os dados: `SELECT * FROM itens_doacao;`
2. 🚀 Deploy do bot: `supabase functions deploy telegram-bot`
3. 🔗 Configure webhook Telegram
4. 🌐 Atualize as variáveis no código (se mudar de projeto)

---

## 💡 Dica: Plano Free do Supabase

O plano gratuito oferece:
- ✅ 500 MB de banco de dados
- ✅ 2 GB de storage
- ✅ Mais que suficiente para este projeto
- ✅ Não expira

---

**🍓 Após identificar o projeto correto, volte ao passo a passo anterior!**
