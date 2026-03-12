# 🚀 GUIA RÁPIDO DE INSTALAÇÃO

## Para Windows (Desenvolvimento Local)

### 1. Instale o Node.js
Baixe e instale o Node.js LTS de: https://nodejs.org/

### 2. Abra o PowerShell na pasta do projeto
```powershell
cd d:\OneDrive\R1\doacoes
npm install
npm start
```

### 3. Acesse no navegador
http://localhost:3001

---

## Para Raspberry Pi (Produção)

### Método 1: Copiar arquivos via SFTP/SCP

```bash
# No seu computador (PowerShell)
# Copie a pasta inteira para o Raspberry Pi
scp -r d:\OneDrive\R1\doacoes pi@IP_DO_RASPBERRY:/home/pi/

# Acesse o Raspberry via SSH
ssh pi@IP_DO_RASPBERRY

# Execute o instalador
cd /home/pi/doacoes
bash install.sh
```

### Método 2: Git (se usar repositório)

```bash
# No Raspberry Pi
git clone seu_repositorio doacoes
cd doacoes
bash install.sh
```

### Método 3: Pen Drive/Cartão SD

1. Copie a pasta `doacoes` para um pen drive
2. Conecte no Raspberry Pi
3. Copie para `/home/pi/`:
```bash
cp -r /media/usb/doacoes /home/pi/
cd /home/pi/doacoes
bash install.sh
```

---

## Iniciar o Sistema

### Iniciar normalmente (teste):
```bash
cd /home/pi/doacoes
npm start
```

### Iniciar em background (recomendado):
```bash
cd /home/pi/doacoes
pm2 start server.js --name doacoes
pm2 save
pm2 startup  # Configura para iniciar no boot
```

---

## Acessar o Sistema

### Na rede local:
1. Descubra o IP do Raspberry:
```bash
hostname -I
```

2. Acesse de qualquer dispositivo na rede:
```
http://IP_DO_RASPBERRY:3001
```
Exemplo: http://192.168.1.100:3001

### Configurar porta diferente:

Crie um arquivo `.env`:
```bash
echo "PORT=8080" > .env
```

Ou edite `server.js` e mude:
```javascript
const PORT = process.env.PORT || 3001; // Mude para sua porta
```

---

## Comandos Úteis

### Ver status do servidor:
```bash
pm2 status
pm2 logs doacoes
```

### Parar/Reiniciar:
```bash
pm2 stop doacoes
pm2 restart doacoes
```

### Fazer backup do banco:
```bash
cp doacoes.db backup_$(date +%Y%m%d).db
```

### Ver dados do banco:
```bash
sqlite3 doacoes.db "SELECT * FROM itens;"
sqlite3 doacoes.db "SELECT * FROM doacoes;"
```

---

## Segurança dos Dados

✅ **Dados são salvos automaticamente** em `doacoes.db`
✅ **Modo WAL ativado** - garante integridade mesmo com falhas
✅ **Transações atômicas** - nada se perde no meio de operações
✅ **Faça backups regulares** do arquivo `doacoes.db`

### Backup automático diário:

```bash
# Crie o script
nano backup.sh
```

Conteúdo:
```bash
#!/bin/bash
BACKUP_DIR="/home/pi/backups"
mkdir -p $BACKUP_DIR
DATE=$(date +%Y%m%d_%H%M%S)
cp /home/pi/doacoes/doacoes.db "$BACKUP_DIR/doacoes_$DATE.db"
# Mantém últimos 30 backups
ls -t $BACKUP_DIR/doacoes_*.db | tail -n +31 | xargs rm -f
echo "Backup criado: doacoes_$DATE.db"
```

```bash
# Torna executável
chmod +x backup.sh

# Agenda no cron (diário às 3h)
crontab -e
# Adicione: 0 3 * * * /home/pi/doacoes/backup.sh
```

---

## Solução de Problemas

### "Porta já em uso"
```bash
# Ver o que está usando a porta
sudo lsof -i :3001
# Ou mude a porta
export PORT=3002
npm start
```

### "Erro de permissão no banco"
```bash
chmod 664 doacoes.db
chmod 775 /home/pi/doacoes
```

### "Não consigo acessar de outro dispositivo"
```bash
# Verifique firewall
sudo ufw allow 3001

# Teste conexão
curl http://localhost:3001/api/itens
```

---

## 📞 Teste Rápido

Após instalação, teste a API:

```bash
# Lista itens
curl http://localhost:3001/api/itens

# Estatísticas
curl http://localhost:3001/api/estatisticas
```

Se retornar JSON, está funcionando! ✅

---

**Sistema pronto para uso! Todos os dados já foram pré-carregados da sua lista.** 🎉
