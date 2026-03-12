$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
$CHAT_ID = 7874363619

Write-Host "`n=== DIAGNOSTICO COMPLETO ===" -ForegroundColor Cyan

# 1. Verificar webhook
Write-Host "`n1. Status do Webhook:" -ForegroundColor Yellow
try {
    $webhook = Invoke-RestMethod -Uri "https://api.telegram.org/bot$TOKEN/getWebhookInfo" -UseBasicParsing
    Write-Host "   URL: $($webhook.result.url)"
    Write-Host "   Pendentes: $($webhook.result.pending_update_count)"
    if ($webhook.result.last_error_message) {
        Write-Host "   ERRO: $($webhook.result.last_error_message)" -ForegroundColor Red
        Write-Host "   Data erro: $($webhook.result.last_error_date)"
    } else {
        Write-Host "   Sem erros!" -ForegroundColor Green
    }
} catch {
    Write-Host "   Erro ao verificar: $_" -ForegroundColor Red
}

# 2. Testar funcao diretamente
Write-Host "`n2. Testando Funcao Edge:" -ForegroundColor Yellow
$testBody = @{
    message = @{
        message_id = 999
        chat = @{ id = $CHAT_ID }
        text = "/start"
    }
} | ConvertTo-Json -Depth 5

try {
    $response = Invoke-WebRequest `
        -Uri "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot" `
        -Method POST `
        -Body $testBody `
        -ContentType "application/json" `
        -UseBasicParsing
    
    Write-Host "   Status: $($response.StatusCode) -  OK!" -ForegroundColor Green
} catch {
    Write-Host "   ERRO: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        Write-Host "   HTTP Status: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
    }
}

# 3. Enviar mensagem de teste via API
Write-Host "`n3. Enviando mensagem teste:" -ForegroundColor Yellow
$testMsg = @{
    chat_id = $CHAT_ID
    text = "Teste de conectividade - $(Get-Date -Format 'HH:mm:ss')"
} | ConvertTo-Json

try {
    $sent = Invoke-RestMethod `
        -Uri "https://api.telegram.org/bot$TOKEN/sendMessage" `
        -Method POST `
        -Body $testMsg `
        -ContentType "application/json" `
        -UseBasicParsing
    
    Write-Host "   Mensagem enviada com sucesso!" -ForegroundColor Green
} catch {
    Write-Host "   Erro ao enviar: $_" -ForegroundColor Red
}

# 4. Verificar atualizacoes pendentes
Write-Host "`n4. Updates Pendentes:" -ForegroundColor Yellow
try {
    $updates = Invoke-RestMethod -Uri "https://api.telegram.org/bot$TOKEN/getUpdates" -UseBasicParsing
    $count = $updates.result.Count
    Write-Host "   Total: $count updates"
    
    if ($count -gt 0) {
        Write-Host "   Ultimos 3 updates:" -ForegroundColor Cyan
        $updates.result | Select-Object -Last 3 | ForEach-Object {
            Write-Host "     - ID: $($_.update_id) | Texto: $($_.message.text)"
        }
    }
} catch {
    Write-Host "   Erro: $_" -ForegroundColor Red
}

Write-Host "`n=== FIM DO DIAGNOSTICO ===`n" -ForegroundColor Cyan
