# Script para pegar Chat ID do Telegram
# IMPORTANTE: Antes de executar, envie uma mensagem para seu bot!

$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
$url = "https://api.telegram.org/bot$TOKEN/getUpdates"

Write-Host "🔍 Buscando mensagens recebidas pelo bot..." -ForegroundColor Cyan
Write-Host ""

try {
    $response = Invoke-RestMethod -Uri $url -Method Get
    
    if ($response.ok -and $response.result.Count -gt 0) {
        Write-Host "✅ Encontrei mensagens!" -ForegroundColor Green
        Write-Host ""
        
        foreach ($update in $response.result) {
            $chatId = $update.message.chat.id
            $nome = $update.message.chat.first_name
            $username = $update.message.chat.username
            $texto = $update.message.text
            
            Write-Host "═══════════════════════════════════" -ForegroundColor Yellow
            Write-Host "Chat ID: $chatId" -ForegroundColor Green
            Write-Host "Nome: $nome" -ForegroundColor Cyan
            if ($username) {
                Write-Host "Username: @$username" -ForegroundColor Cyan
            }
            Write-Host "Mensagem: $texto" -ForegroundColor White
            Write-Host "═══════════════════════════════════" -ForegroundColor Yellow
            Write-Host ""
        }
        
        $primeiroChat = $response.result[0].message.chat.id
        Write-Host "🎯 Use este Chat ID: $primeiroChat" -ForegroundColor Green -BackgroundColor Black
        Write-Host ""
        
    } else {
        Write-Host "⚠️  Nenhuma mensagem encontrada!" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Por favor:" -ForegroundColor Cyan
        Write-Host "1. Abra o Telegram" -ForegroundColor White
        Write-Host "2. Procure por: @doacoesunaadecre_bot" -ForegroundColor White
        Write-Host "3. Envie qualquer mensagem (exemplo: 'oi' ou '/start')" -ForegroundColor White
        Write-Host "4. Execute este script novamente" -ForegroundColor White
        Write-Host ""
    }
    
} catch {
    Write-Host "❌ Erro ao acessar API do Telegram:" -ForegroundColor Red
    Write-Host $_.Exception.Message
    Write-Host ""
    Write-Host "Verifique se o TOKEN está correto!" -ForegroundColor Yellow
}
