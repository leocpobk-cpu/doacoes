$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
$URL = "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot"

Write-Host "1. Deletando webhook..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "https://api.telegram.org/bot$TOKEN/deleteWebhook?drop_pending_updates=true" -UseBasicParsing | Out-Null
Start-Sleep -Seconds 2

Write-Host "2. Configurando webhook novamente..." -ForegroundColor Yellow
$result = Invoke-RestMethod -Uri "https://api.telegram.org/bot$TOKEN/setWebhook?url=$URL" -UseBasicParsing

if ($result.ok) {
    Write-Host "✅ Webhook configurado!" -ForegroundColor Green
    Write-Host "`nAgora teste enviando /start no bot" -ForegroundColor Cyan
} else {
    Write-Host "❌ Erro: $($result.description)" -ForegroundColor Red
}
