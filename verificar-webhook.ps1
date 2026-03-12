$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"

Write-Host "Verificando webhook do bot..." -ForegroundColor Cyan

$url = "https://api.telegram.org/bot$TOKEN/getWebhookInfo"
$info = Invoke-RestMethod -Uri $url

Write-Host ""
Write-Host "STATUS DO WEBHOOK:" -ForegroundColor Yellow
Write-Host "URL configurada: $($info.result.url)" -ForegroundColor White
Write-Host "Pendente: $($info.result.pending_update_count)" -ForegroundColor White
Write-Host ""

if ($info.result.last_error_date) {
    Write-Host "ULTIMO ERRO:" -ForegroundColor Red
    Write-Host "Data: $(Get-Date -UnixTimeSeconds $info.result.last_error_date)" -ForegroundColor Red
    Write-Host "Mensagem: $($info.result.last_error_message)" -ForegroundColor Red
} else {
    Write-Host "Sem erros registrados" -ForegroundColor Green
}
