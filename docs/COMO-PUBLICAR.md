# 🚀 Publicar no GitHub Pages

## ⚠️ ANTES DE COMEÇAR: Alterar Senha de Administrador

**IMPORTANTE:** O sistema está protegido com senha. Apenas administradores podem remover doações.

1. Abra o arquivo `index.html`
2. Procure: `const SENHA_ADMIN = 'admin123';`
3. **Altere para sua senha:** `const SENHA_ADMIN = 'SuaSenhaAqui';`
4. Salve o arquivo

👉 **Veja detalhes em:** [SEGURANCA.md](SEGURANCA.md)

---

## Passo a Passo Simples

### 1. Criar Repositório no GitHub

1. Acesse: https://github.com/new
2. Nome do repositório: `doacoes` (ou qualquer nome)
3. Marque: ✅ **Public**
4. Clique em **Create repository**

---

### 2. Fazer Upload dos Arquivos

**Opção A - Via Interface Web (Mais Fácil):**

1. No repositório criado, clique em **Add file** → **Upload files**
2. Arraste o arquivo `index.html` da pasta `docs/`
3. Escreva uma mensagem: "Sistema de doações"
4. Clique em **Commit changes**

**Opção B - Via Git (se souber usar):**

```bash
cd d:\OneDrive\R1\doacoes\docs
git init
git add index.html
git commit -m "Sistema de doações"
git branch -M main
git remote add origin https://github.com/SEUUSUARIO/doacoes.git
git push -u origin main
```

---

### 3. Ativar GitHub Pages

1. No repositório, clique em **Settings** (Configurações)
2. No menu lateral, clique em **Pages**
3. Em **Source**, selecione: **main** (ou **master**)
4. Em **Folder**, deixe: **/ (root)**
5. Clique em **Save**

Aguarde 1-2 minutos e a página estará online!

---

### 4. Acessar Sua Página

A URL será:

```
https://SEUUSUARIO.github.io/doacoes/
```

Exemplo: `https://joaosilva.github.io/doacoes/`

---

## 📱 Compartilhar com as Pessoas

Depois de publicado, é só **enviar o link** para todos!

- ✅ **Funciona em qualquer celular ou computador**
- ✅ **Sem instalação necessária**
- ✅ **Sem "aviso de site inseguro"**
- ✅ **Link sempre o mesmo** (não muda como ngrok)
- ✅ **Dados salvos automaticamente no navegador de cada pessoa**

---

## 🎯 Como as Pessoas Vão Usar

### Para DOAR:
1. Acessar o link
2. Clicar em **"➕ Doar"** no item desejado
3. Preencher:
   - Nome
   - Região (opcional)
   - Quantidade ou valor
4. Clicar em **"✔ Confirmar"**

**Pronto!** A doação fica registrada automaticamente.

### Para VER as doações:
- Todos veem em tempo real quem doou o quê
- Barra de progresso mostra quanto falta
- Estatísticas no topo

---

## ⚠️ Importante Saber

### ✅ Vantagens:
- Acesso super fácil
- Funciona offline depois da primeira visita
- Visual bonito e responsivo
- Gratuito para sempre

### ⚠️ Limitações:
- Cada pessoa vê suas próprias doações (dados locais)
- Se limpar o navegador, perde os dados
- Não há sincronização automática entre dispositivos

### 💡 Solução para Sincronização:

Se precisar que **todos vejam as mesmas doações em tempo real**, há duas opções:

1. **Firebase (Gratuito)** - posso adaptar o código para usar
2. **Raspberry Pi como backend** - como criamos inicialmente

Para maioria dos casos de uso comunitário, a versão GitHub Pages funciona perfeitamente!

---

## 🔧 Fazer Alterações Depois

Se quiser mudar algo:

1. Edite o arquivo `index.html` localmente
2. No GitHub, clique no arquivo → **Edit** (ícone de lápis)
3. Cole o novo código
4. **Commit changes**

Atualização é instantânea!

---

## 📞 Teste Local Antes de Publicar

Abra o arquivo `docs/index.html` diretamente no navegador:

```
d:\OneDrive\R1\doacoes\docs\index.html
```

Teste tudo antes de publicar!

---

## 🎨 Layout Responsivo

O sistema já está 100% adaptado para:

- 📱 **Smartphones** (até 400px)
- 📱 **Tablets** (400-768px)
- 💻 **Desktops** (768px+)

Funciona perfeitamente em qualquer dispositivo!

---

**Depois de publicar, me avise se funcionou ou se precisa de ajuda!** 🚀
