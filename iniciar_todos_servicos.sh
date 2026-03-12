#!/bin/bash

TITLE="Painel de Controle - Servidor Completo"

echo "=========================================="
echo "  INICIANDO TODOS OS SERVIÇOS"
echo "=========================================="
echo ""

# === SERVIÇO 1: Sistema de Dashboards ===
echo "📊 (1/2) Iniciando Sistema de Dashboards (porta 8000)..."
/home/servidorcpo/venv/bin/python3 /home/servidorcpo/projeto/app.py &
DASHBOARD_PID=$!
echo "   ✓ Dashboard iniciado (PID: $DASHBOARD_PID)"
sleep 2

# === SERVIÇO 2: Sistema de Doações ===
echo ""
echo "🤝 (2/2) Iniciando Sistema de Doações (porta 3001)..."
cd /home/servidorcpo/doacoes
pm2 start server.js --name doacoes 2>/dev/null || node server.js &
DOACOES_PID=$!
echo "   ✓ Doações iniciado (PID: $DOACOES_PID)"
sleep 3

# === VERIFICAÇÃO ===
echo ""
echo "=========================================="
echo "  ✅ SERVIÇOS ATIVOS"
echo "=========================================="
echo ""
echo "📊 Dashboards:  http://localhost:8000"
echo "🤝 Doações:     http://localhost:3001"
echo ""
echo "Para acesso externo (ngrok):"
echo "  Dashboard:  ngrok http 8000"
echo "  Doações:    ngrok http 3001"
echo ""
echo "=========================================="
echo ""

# Opcional: Inicia ngrok para o dashboard automaticamente
read -p "Deseja iniciar ngrok para Dashboards? (s/n): " resposta
if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
    echo ""
    echo "🌐 Iniciando ngrok para Dashboards (porta 8000)..."
    ngrok http 8000
fi

echo ""
echo "Script finalizado."
