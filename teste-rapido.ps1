$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"

Write-Host "Testando funcao..." -ForegroundColor Cyan

$body = @{
    message = @{
        message_id = 999
        chat = @{
            id = 7874363619
        }
        text = "/start"
    }
} | ConvertTo-Json -Depth 5

try {
    $response = Invoke-WebRequest `
        -Uri "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot" `
        -Method POST `
        -Body $body `
        -ContentType "application/json" `
        -UseBasicParsing
    
    Write-Host "Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Resposta: $($response.Content)"
} catch {
    Write-Host "ERRO: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        Write-Host "Status Code: $($_.Exception.Response.StatusCode.value__)"
    }
}

Write-Host "`nVerificando webhook..." -ForegroundColor Cyan
try {
    $webhook = Invoke-RestMethod -Uri "https://api.telegram.org/bot$TOKEN/getWebhookInfo" -UseBasicParsing
    Write-Host "URL: $($webhook.result.url)"
    Write-Host "Pendente: $($webhook.result.pending_update_count)"
    if ($webhook.result.last_error_message) {
        Write-Host "Erro: $($webhook.result.last_error_message)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "Erro ao verificar webhook: $($_.Exception.Message)"
}
