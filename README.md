# 🤝 Sistema de Controle de Doações

Sistema completo para gerenciamento de doações de viveres com interface web moderna e banco de dados SQLite.

## 📋 Características

- ✅ Controle de doações por item com quantidade total e doada
- 👥 Registro de doadores com nome e região
- 💰 Suporte para doações em dinheiro ou item físico
- 📊 Estatísticas em tempo real
- 🎨 Interface moderna e responsiva
- 💾 Banco de dados SQLite com transações seguras
- 🔄 Atualização automática de quantidades
- 🗑️ Remover doações se necessário

## 🚀 Instalação no Raspberry Pi

### Pré-requisitos

```bash
# Atualiza o sistema
sudo apt update && sudo apt upgrade -y

# Instala Node.js 18.x ou superior
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verifica instalação
node --version
npm --version
```

### Instalação do Sistema

```bash
# 1. Copia os arquivos para o Raspberry Pi
# (Use SFTP, SCP ou um pen drive)

# 2. Acessa a pasta do projeto
cd /caminho/para/doacoes

# 3. Instala as dependências
npm install

# 4. Testa o servidor
npm start
```

O servidor iniciará em `http://localhost:3001`

### 🔧 Configurar Porta Diferente

Se você já usa a porta 3001, edite o arquivo `server.js`:

```javascript
const PORT = process.env.PORT || 3002; // Mude para sua porta desejada
```

Ou defina a variável de ambiente:

```bash
export PORT=3002
npm start
```

## 🌐 Hospedar Permanentemente

### Opção 1: PM2 (Recomendado)

```bash
# Instala PM2 globalmente
sudo npm install -g pm2

# Inicia o aplicativo
pm2 start server.js --name doacoes

# Configura para iniciar automaticamente no boot
pm2 startup
pm2 save

# Comandos úteis:
pm2 status              # Ver status
pm2 logs doacoes       # Ver logs
pm2 restart doacoes    # Reiniciar
pm2 stop doacoes       # Parar
```

### Opção 2: Systemd Service

Crie o arquivo `/etc/systemd/system/doacoes.service`:

```ini
[Unit]
Description=Sistema de Doações
After=network.target

[Service]
Type=simple
User=pi
WorkingDirectory=/caminho/para/doacoes
ExecStart=/usr/bin/node server.js
Restart=on-failure
Environment=PORT=3001

[Install]
WantedBy=multi-user.target
```

Ative o serviço:

```bash
sudo systemctl daemon-reload
sudo systemctl enable doacoes
sudo systemctl start doacoes
sudo systemctl status doacoes
```

## 🔐 Configurar Acesso Externo

### 1. Encontre o IP do Raspberry Pi

```bash
hostname -I
```

### 2. Acesse de outros dispositivos na rede

Acesse: `http://IP_DO_RASPBERRY:3001`

Exemplo: `http://192.168.1.100:3001`

### 3. Configurar Nginx (Opcional - para domínio)

```bash
# Instala Nginx
sudo apt install -y nginx

# Cria configuração
sudo nano /etc/nginx/sites-available/doacoes
```

Conteúdo:

```nginx
server {
    listen 80;
    server_name doacoes.local; # ou seu domínio

    location / {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Ativa:

```bash
sudo ln -s /etc/nginx/sites-available/doacoes /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## 📊 Estrutura do Banco de Dados

O sistema usa SQLite com duas tabelas principais:

### Tabela `itens`
- `id`: ID único
- `descricao`: Nome do item
- `quantidade_total`: Quantidade necessária
- `unidade`: Unidade de medida
- `quantidade_doada`: Quanto já foi doado
- `created_at`, `updated_at`: Timestamps

### Tabela `doacoes`
- `id`: ID único
- `item_id`: Referência ao item
- `doador_nome`: Nome do doador
- `doador_regiao`: Região do doador (opcional)
- `quantidade`: Quantidade doada
- `tipo`: 'item' ou 'dinheiro'
- `valor_dinheiro`: Valor em R$ (se tipo = dinheiro)
- `observacao`: Observações adicionais
- `created_at`: Timestamp

## 🔒 Segurança dos Dados

- ✅ Banco SQLite com modo WAL (Write-Ahead Logging)
- ✅ Transações atômicas para consistência
- ✅ Backup automático através do WAL
- ✅ Validações de dados no backend

### Fazer Backup Manual

```bash
# Backup simples
cp doacoes.db doacoes.db.backup

# Backup com data
cp doacoes.db "backup_$(date +%Y%m%d_%H%M%S).db"

# Criar script de backup automático
```

Crie `backup.sh`:

```bash
#!/bin/bash
BACKUP_DIR="/caminho/para/backups"
DATE=$(date +%Y%m%d_%H%M%S)
cp /caminho/para/doacoes/doacoes.db "$BACKUP_DIR/doacoes_$DATE.db"
# Mantém apenas os últimos 30 backups
ls -t $BACKUP_DIR/doacoes_*.db | tail -n +31 | xargs rm -f
```

Configure no cron:

```bash
# Edita crontab
crontab -e

# Adiciona: backup diário às 3h da manhã
0 3 * * * /caminho/para/backup.sh
```

## 🛠️ API Endpoints

- `GET /api/itens` - Lista todos os itens com doações
- `GET /api/itens/:id` - Busca item específico
- `POST /api/doacoes` - Registra nova doação
- `DELETE /api/doacoes/:id` - Remove doação
- `GET /api/estatisticas` - Estatísticas gerais

## 📱 Uso do Sistema

1. **Ver itens disponíveis**: A página mostra todos os itens com barra de progresso
2. **Fazer doação**: Clique em "Doar" no item desejado
3. **Preencher formulário**:
   - Nome do doador
   - Região (opcional)
   - Tipo: item ou dinheiro
   - Quantidade
   - Observações (opcional)
4. **Remover doação**: Clique no ícone da lixeira

## 🎨 Personalização

### Alterar cores (em `public/index.html`):

```css
/* Altere o gradiente principal */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Altere a cor primária */
color: #667eea;
```

### Adicionar novos itens via código:

Edite `database.js` na função `seedDatabase()`.

## ⚡ Performance

- Usa índices no banco de dados
- Modo WAL para melhor concorrência
- Transações para operações atômicas
- Cache de recursos estáticos

## 🐛 Solução de Problemas

### Porta já em uso
```bash
# Ver o que está usando a porta
sudo lsof -i :3001

# Ou mude a porta no .env
echo "PORT=3002" > .env
```

### Permissões do banco de dados
```bash
chmod 664 doacoes.db
chmod 775 .
```

### Banco corrompido
```bash
# Restaura do backup
cp doacoes.db.backup doacoes.db

# Ou limpa e reinicia
rm doacoes.db*
npm start
```

## 📞 Suporte

Para dúvidas ou problemas:
1. Verifique os logs: `pm2 logs doacoes`
2. Teste a conexão: `curl http://localhost:3001/api/itens`
3. Verifique o banco: `sqlite3 doacoes.db "SELECT * FROM itens;"`

---

**Desenvolvido para gestão eficiente de doações comunitárias** 🤝
