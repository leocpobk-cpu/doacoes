# Teste de integracao Telegram
$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
$CHAT = "7874363619"

$msg = @"
TESTE DE NOTIFICACAO!

Doador: Leonardo (R1)
Item: Arroz 5 pacotes de 5kg
Valor: R$ 18.00
Equivale a: 1 pacote

Se voce recebeu esta mensagem, a integracao esta funcionando!
"@

$url = "https://api.telegram.org/bot$TOKEN/sendMessage"
$body = @{ chat_id = $CHAT; text = $msg } | ConvertTo-Json

try {
    $r = Invoke-RestMethod -Uri $url -Method Post -Body $body -ContentType "application/json"
    if ($r.ok) {
        Write-Host "Mensagem enviada! Verifique seu Telegram!" -ForegroundColor Green
    }
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}
