#!/bin/bash

# Script de instalação rápida para Raspberry Pi
# Execute com: bash install.sh

echo "🚀 Instalando Sistema de Doações..."
echo ""

# Verifica se Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "📦 Node.js não encontrado. Instalando..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
else
    echo "✅ Node.js já instalado: $(node --version)"
fi

# Instala dependências
echo ""
echo "📦 Instalando dependências..."
npm install

# Verifica se PM2 está instalado
if ! command -v pm2 &> /dev/null; then
    echo ""
    echo "📦 Instalando PM2 para gerenciamento..."
    sudo npm install -g pm2
fi

echo ""
echo "✅ Instalação concluída!"
echo ""
echo "Para iniciar o servidor:"
echo "  Normal: npm start"
echo "  Background (PM2): pm2 start server.js --name doacoes"
echo ""
echo "Acesse em: http://localhost:3001"
echo ""
