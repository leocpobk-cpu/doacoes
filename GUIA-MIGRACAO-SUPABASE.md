# 🚀 Guia de Migração para Supabase

## ⚠️ IMPORTANTE 
Este guia vai configurar o sistema de doações para usar banco de dados online (Supabase).
Após esta configuração, **todos verão as mesmas doações em tempo real**.

---

## 📋 PASSO 1: Executar SQL no Supabase

1. Acesse: https://supabase.com/dashboard/project/fwmlimudntlrkeukvyjg
2. No menu lateral, clique em **SQL Editor**
3. Clique em **+ New Query**
4. Copie TODO o conteúdo do arquivo: `supabase-doacoes-schema.sql`
5. Cole no editor SQL
6. Clique em **RUN** (canto inferior direito)
7. Aguarde a mensagem: **Success. No rows returned**

### ✅ O que esse SQL faz:
- Cria 2 tabelas: `itens_doacao` e `doacoes`
- Insere os 23 itens necessários
- Insere as 10 doações já existentes (Denner, Daniel, Dc Lucas, Damião, Gabriel)
- Configura permissões (todos podem ver e registrar, apenas admin pode deletar)

---

## 📋 PASSO 2: Testar Localmente

1. Abra no navegador: `d:\OneDrive\R1\doacoes\docs\index-supabase.html`
2. Verifique se os itens aparecem corretamente
3. Teste registrar uma doação
4. Abra em outra aba ou outro dispositivo - deve mostrar a mesma doação!
5. Teste remover uma doação (requer senha admin: `0016275784390`)

---

## 📋 PASSO 3: Atualizar GitHub Pages

Se tudo funcionar no teste local:

### Opção A: Renomear arquivos localmente e fazer upload

1. **Renomeie os arquivos:**
   - Renomeie `index.html` para `index-old.html` (backup)
   - Renomeie `index-supabase.html` para `index.html`

2. **Atualize no GitHub:**
   - Acesse: https://github.com/leocopbk-cpu/doacoesumaadcro
   - Clique em **index.html**
   - Clique no ícone do **lápis** (Edit)
   - Selecione todo conteúdo (Ctrl+A) e apague
   - Abra o novo `index.html` local, copie tudo (Ctrl+A, Ctrl+C)
   - Cole no GitHub
   - Clique em **Commit changes**

### Opção B: Copiar e colar diretamente

1. Abra: `d:\OneDrive\R1\doacoes\docs\index-supabase.html`
2. Copie todo o conteúdo (Ctrl+A, Ctrl+C)
3. Acesse: https://github.com/leocopbk-cpu/doacoesumaadcro
4. Clique em **index.html** → Ícone do **lápis**
5. Selecione tudo (Ctrl+A), apague
6. Cole o novo conteúdo (Ctrl+V)
7. Clique em **Commit changes**

---

## 📋 PASSO 4: Verificar GitHub Pages

1. Aguarde 1-2 minutos
2. Acesse: https://leocopbk-cpu.github.io/doacoesumaadcro/
3. Pressione **Ctrl+Shift+R** (limpar cache do navegador)
4. Verifique se os dados aparecem
5. Se aparecer "undefined" ou dados antigos:
   - Pressione **F12** (Console)
   - Digite: `localStorage.clear(); location.reload();`
   - Pressione **Enter**

---

## ✅ PRONTO!

Agora o sistema está 100% funcional com banco de dados online:
- ✅ Todos veem as mesmas doações
- ✅ Dados salvos na nuvem
- ✅ Funciona em qualquer dispositivo
- ✅ Atualização automática para todos

---

## 🔐 Segurança

- **Senha Admin:** `0016275784390`
- Todos podem registrar doações
- Apenas admin pode remover doações
- Se quiser mudar a senha, edite a linha 415 do `index.html`:
  ```javascript
  const SENHA_ADMIN = '0016275784390';
  ```

---

## 🆘 Problemas?

### Erro: "Erro ao carregar dados"
- Verifique se executou o SQL no Supabase
- Verifique se as tabelas existem (SQL Editor → painel esquerdo)

### Dados não aparecem
- Limpe o cache: `localStorage.clear(); location.reload();`
- Verifique sua conexão com internet

### Doação não salva
- Verifique se as políticas RLS estão ativas
- Veja o console do navegador (F12) para ver erros

---

## 📞 Suporte

Se precisar de ajuda, me chame novamente!
