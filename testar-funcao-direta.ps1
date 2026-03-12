$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
$FUNCTION_URL = "https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/telegram-bot"

Write-Host "Testando funcao diretamente..." -ForegroundColor Cyan

# Simula mensagem do Telegram
$body = @{
    message = @{
        chat = @{ id = 7874363619 }
        text = "/start"
    }
} | ConvertTo-Json -Depth 3

try {
    $response = Invoke-RestMethod -Uri $FUNCTION_URL -Method Post -Body $body -ContentType "application/json"
    Write-Host "Resposta da funcao: $response" -ForegroundColor Green
} catch {
    Write-Host "ERRO ao chamar funcao:" -ForegroundColor Red
    Write-Host $_.Exception.Message
    Write-Host $_.Exception.Response
}
