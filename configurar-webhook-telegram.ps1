# Script para configurar webhook do bot Telegram
# Execute apos fazer deploy da Edge Function

$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
$WEBHOOK_URL = "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot"

Write-Host "Configurando webhook do bot Telegram..." -ForegroundColor Cyan

# Define webhook
$setWebhook = "https://api.telegram.org/bot$TOKEN/setWebhook"
$body = @{ url = $WEBHOOK_URL } | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri $setWebhook -Method Post -Body $body -ContentType "application/json"
    
    if ($response.ok) {
        Write-Host "Webhook configurado com sucesso!" -ForegroundColor Green
        Write-Host "URL: $WEBHOOK_URL" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Teste enviando mensagens para o bot:" -ForegroundColor Yellow
        Write-Host "/start" -ForegroundColor White
        Write-Host "/status" -ForegroundColor White
        Write-Host "/itens" -ForegroundColor White
    } else {
        Write-Host "Erro: $($response.description)" -ForegroundColor Red
    }
} catch {
    Write-Host "Erro ao configurar webhook:" -ForegroundColor Red
    Write-Host $_.Exception.Message
}

Write-Host ""
Write-Host "Para verificar status do webhook:" -ForegroundColor Cyan
Write-Host "https://api.telegram.org/bot$TOKEN/getWebhookInfo" -ForegroundColor Gray
