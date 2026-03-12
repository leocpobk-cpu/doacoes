$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"

Write-Host "1. Removendo webhook antigo..." -ForegroundColor Yellow
Invoke-WebRequest "https://api.telegram.org/bot$TOKEN/deleteWebhook" | Out-Null

Start-Sleep -Seconds 2

Write-Host "2. Configurando novo webhook..." -ForegroundColor Cyan
$url = "https://api.telegram.org/bot$TOKEN/setWebhook"
$body = @{ 
    url = "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot"
    drop_pending_updates = $true
} | ConvertTo-Json

$response = Invoke-RestMethod -Uri $url -Method Post -Body $body -ContentType "application/json"

if ($response.ok) {
    Write-Host "Webhook configurado!" -ForegroundColor Green
    Write-Host ""
    Write-Host "3. Verificando..." -ForegroundColor Cyan
    
    $info = Invoke-RestMethod "https://api.telegram.org/bot$TOKEN/getWebhookInfo"
    Write-Host "URL: $($info.result.url)" -ForegroundColor White
    Write-Host "Pendentes: $($info.result.pending_update_count)" -ForegroundColor White
    
    Write-Host ""
    Write-Host "Agora envie /start no bot!" -ForegroundColor Yellow
} else {
    Write-Host "Erro: $($response.description)" -ForegroundColor Red
}
