$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"

Write-Host "Verificando webhook..." -ForegroundColor Cyan
$webhook = Invoke-RestMethod "https://api.telegram.org/bot$TOKEN/getWebhookInfo"
Write-Host "URL: $($webhook.result.url)"
Write-Host "Pendentes: $($webhook.result.pending_update_count)"
Write-Host "Ultimo erro: $($webhook.result.last_error_message)"

Write-Host "`nTestando funcao..." -ForegroundColor Cyan
$body = '{"message":{"chat":{"id":7874363619},"text":"/start"}}'
try {
    $resp = Invoke-WebRequest -Uri "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot" -Method POST -Body $body -ContentType "application/json" -UseBasicParsing
    Write-Host "Status: $($resp.StatusCode)"
} catch {
    Write-Host "Erro: $($_.Exception.Message)"
}
