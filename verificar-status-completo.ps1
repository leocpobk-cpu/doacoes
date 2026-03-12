# Verificação completa do bot

$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"

Write-Host "`n=== 1. INFO DO BOT ===" -ForegroundColor Cyan
$botInfo = Invoke-RestMethod -Uri "https://api.telegram.org/bot$TOKEN/getMe"
Write-Host "Bot: $($botInfo.result.username)"
Write-Host "ID: $($botInfo.result.id)"

Write-Host "`n=== 2. WEBHOOK INFO ===" -ForegroundColor Cyan
$webhook = Invoke-RestMethod -Uri "https://api.telegram.org/bot$TOKEN/getWebhookInfo"
Write-Host "URL: $($webhook.result.url)"
Write-Host "Pendente: $($webhook.result.pending_update_count) updates"
Write-Host "Ultimo erro: $($webhook.result.last_error_message)"
Write-Host "Data do erro: $($webhook.result.last_error_date)"

Write-Host "`n=== 3. TESTANDO FUNCAO DIRETAMENTE ===" -ForegroundColor Cyan
$testBody = @{
    message = @{
        message_id = 999
        chat = @{
            id = 7874363619
        }
        text = "/start"
    }
} | ConvertTo-Json -Depth 5

try {
    $response = Invoke-RestMethod -Uri "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot" `
        -Method POST `
        -Body $testBody `
        -ContentType "application/json" `
        -ErrorAction Stop
    Write-Host "✅ Funcao respondeu: $response" -ForegroundColor Green
} catch {
    Write-Host "❌ ERRO: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Status: $($_.Exception.Response.StatusCode.value__)"
}

Write-Host "`n=== 4. ENVIANDO MENSAGEM DE TESTE ===" -ForegroundColor Cyan
$testMsg = @{
    chat_id = 7874363619
    text = "🔍 Teste de conectividade - $(Get-Date -Format 'HH:mm:ss')"
} | ConvertTo-Json

$sent = Invoke-RestMethod -Uri "https://api.telegram.org/bot$TOKEN/sendMessage" `
    -Method POST `
    -Body $testMsg `
    -ContentType "application/json"

Write-Host "Mensagem enviada com sucesso" -ForegroundColor Green
