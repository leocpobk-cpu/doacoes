# 🚀 Passo a Passo - Configurar Feira Gastronômica no Supabase

## ⚠️ IMPORTANTE
Este processo vai **APAGAR TODOS OS DADOS ANTIGOS** e criar uma nova base com os itens da Feira Gastronômica.

---

## 📋 Passo 1: Copiar o SQL

1. Abra o arquivo: **`setup-feira-gastronomica-coophamil.sql`**
2. Selecione **TODO O CONTEÚDO** do arquivo (Ctrl+A)
3. Copie (Ctrl+C)

---

## 🌐 Passo 2: Acessar o Supabase

1. Acesse: **https://supabase.com/dashboard**
2. Faça login na sua conta
3. Selecione o **projeto das doações**

---

## 💾 Passo 3: Abrir o SQL Editor

1. No menu lateral esquerdo, clique em: **SQL Editor** (ícone de código)
2. Clique no botão: **+ New query** (no canto superior direito)

---

## 📝 Passo 4: Colar e Executar

1. Cole **TODO O CONTEÚDO** do arquivo SQL na área de texto
2. Clique no botão: **Run** (ou pressione Ctrl+Enter)
3. Aguarde a execução (deve levar alguns segundos)
4. Verifique se apareceu "Success. No rows returned" ou similar

---

## ✅ Passo 5: Verificar os Dados

Execute esta query para confirmar que os 15 itens foram criados:

```sql
SELECT * FROM itens_doacao ORDER BY id;
```

Você deve ver os 15 itens:
1. Banana (30 unidades)
2. Maçã grande (12 unidades)
3. Mamão Formosa (2 unidades)
4. Melão médio (2 unidades)
5. Laranja (20 unidades)
6. Abacaxi grande (3 unidades)
7. Uva sem caroço (2.5 kg)
8. Morangos (6 bandejas)
9. Kiwi (12 unidades)
10. Maracujá (4 unidades)
11. Colher descartável (50 unidades)
12. Copos com tampa (50 unidades)
13. Leite condensado (8 latas)
14. Creme de leite (8 latas)
15. Suco de maracujá (2 garrafinhas)

---

## 🤖 Passo 6: Atualizar o Bot Telegram (Opcional)

Se você já tem o bot configurado, faça o deploy da nova versão:

```powershell
supabase functions deploy telegram-bot
```

**OU** use o script facilitador:

```powershell
.\atualizar-feira-gastronomica.ps1
```

---

## 🌐 Passo 7: Atualizar o Site

O arquivo **`docs/index-supabase.html`** já está atualizado com:
- ✅ Título: "Feira Gastronômica COOPHAMIL"
- ✅ PIX: leocpo@gmail.com (Leonardo Cezario Pinto de Oliveira)

Se estiver usando GitHub Pages, faça commit e push das alterações:

```powershell
git add .
git commit -m "Atualização para Feira Gastronômica COOPHAMIL"
git push
```

---

## 📊 Queries Úteis para Acompanhar

### Ver todas as doações recebidas:
```sql
SELECT * FROM doacoes ORDER BY data_doacao DESC;
```

### Ver progresso de cada item:
```sql
SELECT 
    i.id,
    i.descricao,
    i.quantidade_total,
    i.unidade,
    COALESCE(SUM(d.quantidade), 0) as doado,
    i.quantidade_total - COALESCE(SUM(d.quantidade), 0) as faltando
FROM itens_doacao i
LEFT JOIN doacoes d ON d.item_id = i.id
GROUP BY i.id, i.descricao, i.quantidade_total, i.unidade
ORDER BY i.id;
```

### Limpar todas as doações (manter itens):
```sql
DELETE FROM doacoes;
```

---

## 🆘 Problemas Comuns

### ❌ Erro: "relation already exists"
**Solução:** O SQL já limpa tudo automaticamente. Execute novamente.

### ❌ Erro: "permission denied"
**Solução:** Certifique-se de estar logado com a conta do projeto.

### ❌ Bot não responde
**Solução:** 
1. Verifique se as variáveis de ambiente estão configuradas
2. Faça deploy novamente: `supabase functions deploy telegram-bot`
3. Reconfigure o webhook: `.\configurar-webhook-telegram.ps1`

---

## 📞 Suporte

**PIX:** leocpo@gmail.com  
**Favorecido:** Leonardo Cezario Pinto de Oliveira

---

**🍓 Boa sorte com a Feira Gastronômica COOPHAMIL!**
