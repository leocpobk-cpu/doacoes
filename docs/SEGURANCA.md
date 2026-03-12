# 🔐 Configuração de Segurança - Sistema de Doações

## ⚠️ IMPORTANTE: Alterar Senha de Administrador

Por padrão, o sistema usa a senha: `admin123`

**Você DEVE alterar esta senha antes de publicar!**

---

## 📝 Como Alterar a Senha

### 1. Abra o arquivo `index.html`

### 2. Procure esta linha (próxima ao início do código JavaScript):

```javascript
const SENHA_ADMIN = 'admin123'; // ⚠️ ALTERE ESTA SENHA!
```

### 3. Substitua por sua senha:

```javascript
const SENHA_ADMIN = 'MinhaSenh@Segur@2026';
```

### 4. Salve o arquivo e faça upload no GitHub

---

## 🔒 O Que Está Protegido

### ✅ **Ações que EXIGEM senha de administrador:**

1. **Remover doações** (botão 🗑️)
   - Apenas você poderá excluir doações registradas
   
2. **Resetar todos os dados**
   - Função `resetarDados()` no console (para emergências)

### ✅ **Ações LIVRES para todos:**

1. **Adicionar doações**
   - Qualquer pessoa pode registrar sua doação
   - Dados são validados automaticamente

2. **Visualizar doações**
   - Todos podem ver o progresso e quem doou

---

## 🛡️ Dicas de Segurança

### ✅ **Escolha uma senha forte:**
- Mínimo 8 caracteres
- Misture letras, números e símbolos
- Não use senhas óbvias como "12345" ou "senha"

### ✅ **Guarde a senha em local seguro:**
- Anote em local físico seguro
- Ou use gerenciador de senhas

### ⚠️ **Nunca compartilhe a senha:**
- Apenas você (administrador) deve saber
- Se compartilhar, qualquer um poderá deletar doações

---

## 🚨 Emergência: Esqueci a Senha

Se esquecer a senha, será necessário:

1. **Baixar o arquivo `index.html` do GitHub**
2. **Editar localmente e alterar a senha**
3. **Fazer upload novamente**

Ou criar um novo repositório com senha nova.

---

## 🔧 Para Desenvolvedores

### Como testar proteção localmente:

```javascript
// Abra o Console do navegador (F12)

// Tentar resetar dados (pede senha):
resetarDados();

// Tentar remover doação (pede senha):
removerDoacao(1);
```

### Fluxo de autenticação:

```
Usuário clica em "Remover"
    ↓
Prompt de senha aparece
    ↓
Verifica senha === SENHA_ADMIN
    ↓
✅ Correto = Remove     ❌ Incorreto = Bloqueia
```

---

## 📱 Comportamento no Celular

- Prompt de senha funciona normalmente
- Teclado virtual aparece automaticamente
- Botões grandes e fáceis de tocar
- Mensagens claras de erro/sucesso

---

## ⚙️ Configurações Avançadas (Opcional)

### Múltiplos Administradores:

Edite a validação de senha:

```javascript
const SENHAS_ADMIN = ['senha_admin1', 'senha_admin2', 'senha_admin3'];

// Na função, substitua:
if (senha !== SENHA_ADMIN) {
// Por:
if (!SENHAS_ADMIN.includes(senha)) {
```

### Log de remoções:

Adicione antes de remover:

```javascript
console.log(`[${new Date().toISOString()}] Admin removeu doação ID ${doacaoId}`);
```

---

## ✅ Checklist Antes de Publicar

- [ ] Senha alterada de `admin123` para senha forte
- [ ] Senha anotada em local seguro
- [ ] Testado localmente (remover doação pede senha)
- [ ] Arquivo salvo e commitado no GitHub
- [ ] GitHub Pages atualizado

---

**Sistema protegido e pronto para uso público!** 🎉

**Lembre-se:** Qualquer pessoa pode DOAR, mas apenas o administrador pode REMOVER.
