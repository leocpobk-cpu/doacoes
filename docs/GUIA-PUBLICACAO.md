# 📤 Guia Completo: Publicar no GitHub Pages

## ⚠️ ANTES DE COMEÇAR

### 1. Alterar a Senha de Administrador

**IMPORTANTE:** Abra o arquivo `index.html` e altere a senha!

1. Clique com botão direito em `index.html` → **Abrir com** → **Bloco de notas**
2. Pressione `Ctrl + F` e procure por: `admin123`
3. Você vai encontrar esta linha:
   ```javascript
   const SENHA_ADMIN = 'admin123'; // ⚠️ ALTERE ESTA SENHA!
   ```
4. Altere para sua senha forte:
   ```javascript
   const SENHA_ADMIN = 'MinhaSenh@Forte2026';
   ```
5. Salve o arquivo (`Ctrl + S`)

---

## 📝 PASSO 1: Criar Conta no GitHub

Se você já tem conta, pode pular para o Passo 2.

1. Acesse: https://github.com/signup
2. Preencha:
   - Email
   - Senha
   - Username (escolha um nome simples, será usado na URL)
3. Resolva o puzzle de verificação
4. Clique em **Create account**
5. Verifique seu email e confirme

---

## 📦 PASSO 2: Criar Repositório

1. **Faça login no GitHub**
   - Acesse: https://github.com/login
   - Entre com seu usuário e senha

2. **Criar novo repositório**
   - Clique no **+** no canto superior direito
   - Selecione **New repository**

3. **Configurar o repositório:**
   - **Repository name:** `doacoes` (ou qualquer nome que preferir)
   - **Description:** "Sistema de controle de doações"
   - **Public:** ✅ Marque esta opção (obrigatório para GitHub Pages grátis)
   - **NÃO** marque "Add a README file"
   - Clique em **Create repository**

---

## 📤 PASSO 3: Fazer Upload do Arquivo

Você vai ver uma página com várias opções. Escolha a mais fácil:

### Opção A - Upload pela Interface (MAIS FÁCIL)

1. **Na página do repositório criado, clique em:**
   - `uploading an existing file` (link azul no meio da página)
   - OU clique em **Add file** → **Upload files**

2. **Arraste o arquivo:**
   - Abra a pasta: `D:\OneDrive\R1\doacoes\docs\`
   - **Arraste o arquivo `index.html`** para a área de upload

3. **Commit:**
   - Na parte inferior, em "Commit changes"
   - Deixe a mensagem: "Add files via upload"
   - Clique em **Commit changes** (botão verde)

### Opção B - Copiar e Colar (ALTERNATIVA)

1. **Criar arquivo:**
   - Clique em **Add file** → **Create new file**

2. **Nome do arquivo:**
   - No campo "Name your file...", digite: `index.html`

3. **Copiar código:**
   - Abra o arquivo `D:\OneDrive\R1\doacoes\docs\index.html`
   - Selecione todo o conteúdo (`Ctrl + A`)
   - Copie (`Ctrl + C`)

4. **Colar no GitHub:**
   - Volte para o GitHub
   - Clique na área de texto grande
   - Cole o código (`Ctrl + V`)

5. **Commit:**
   - Role até o final
   - Clique em **Commit changes** (botão verde)

---

## 🌐 PASSO 4: Ativar GitHub Pages

1. **Ir para Settings:**
   - No seu repositório, clique na aba **Settings** (configurações)
   - Está no menu horizontal, última opção à direita

2. **Acessar Pages:**
   - No menu lateral esquerdo, role até encontrar **Pages**
   - Clique em **Pages**

3. **Configurar Source:**
   - Em **Branch**, selecione: `main` (ou `master`)
   - Mantenha a pasta como: `/ (root)`
   - Clique em **Save**

4. **Aguardar:**
   - Aparecerá uma mensagem: "Your site is ready to be published..."
   - Aguarde 1-2 minutos
   - Recarregue a página (`F5`)

5. **URL Pronta! 🎉**
   - Aparecerá uma caixa verde com:
   - "Your site is live at `https://SEUUSUARIO.github.io/doacoes/`"
   - **Este é o link para compartilhar!**

---

## 📱 PASSO 5: Testar e Compartilhar

### Testar:

1. Clique no link ou copie e cole no navegador
2. Teste adicionar uma doação:
   - Clique em **Doar** em algum item
   - Preencha seu nome
   - Escolha quantidade
   - Clique em **Registrar**
3. Verifique se apareceu na lista

### Compartilhar:

Sua URL será algo como:
```
https://joaosilva.github.io/doacoes/
```

🎉 **Compartilhe este link com todos!**

- Envie via WhatsApp
- Poste nas redes sociais
- Envie por email
- Cole em anúncios

---

## 🔧 PASSO 6: Fazer Alterações Depois

Se precisar mudar algo no futuro:

1. Acesse seu repositório no GitHub
2. Clique no arquivo `index.html`
3. Clique no ícone de **lápis** (Edit this file)
4. Faça as alterações
5. Role até o final e clique em **Commit changes**
6. A página será atualizada automaticamente em 1-2 minutos

---

## ❓ PROBLEMAS COMUNS

### "404 - File not found"
- Aguarde 5 minutos após ativar o Pages
- Verifique se o arquivo se chama exatamente `index.html` (minúsculas)
- Certifique-se de que o repositório é **público**

### "Não consigo ativar Pages"
- Repositório precisa ser **público** (Settings → Change visibility)
- Verifique se está logado na conta correta

### "Link não funciona"
- Aguarde alguns minutos (pode demorar até 10 minutos na primeira vez)
- Tente acessar no modo anônimo do navegador
- Limpe o cache (`Ctrl + Shift + Delete`)

### "Dados não salvam"
- Os dados são salvos no navegador de cada pessoa
- Se limpar cache/cookies, perde os dados
- Isso é normal (cada um vê suas próprias doações registradas)

---

## 📊 RESUMO DO QUE VOCÊ TEM

✅ **Sistema Completo:**
- Lista simples de 23 itens
- Doações já registradas (Denner, Daniel Alves, Dc Lucas, etc.)
- Qualquer um pode doar
- Só você (admin) pode remover
- Responsivo para celular
- Dados salvos automaticamente

✅ **URL Permanente:**
- Link fixo que não muda
- Sem avisos de segurança
- Acesso direto e simples
- Funciona em qualquer dispositivo

---

## 🎯 CHECKLIST FINAL

Antes de compartilhar, verifique:

- [ ] Senha alterada de `admin123` para sua senha
- [ ] Testou adicionar uma doação
- [ ] Testou remover uma doação (com senha)
- [ ] Abriu no celular e funcionou
- [ ] Link copiado e pronto para compartilhar

---

## 📞 Precisa de Ajuda?

Se tiver dúvidas em algum passo:

1. **Tire um print da tela** onde está com dúvida
2. **Anote qual passo** está tentando fazer
3. **Descreva o erro** que aparece

Estou aqui para ajudar! 🚀

---

**Tempo estimado:** 10-15 minutos
**Dificuldade:** Fácil
**Custo:** R$ 0,00 (100% gratuito)

🎉 **Boa sorte com suas doações!**
