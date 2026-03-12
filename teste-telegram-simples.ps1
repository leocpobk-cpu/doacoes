$TOKEN = "8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ"
$CHAT = "7874363619"
$msg = "TESTE: Integracao Telegram funcionando!"
$url = "https://api.telegram.org/bot$TOKEN/sendMessage"
$body = @{ chat_id = $CHAT; text = $msg } | ConvertTo-Json
$r = Invoke-RestMethod -Uri $url -Method Post -Body $body -ContentType "application/json"
if ($r.ok) { Write-Host "OK! Verifique seu Telegram" -ForegroundColor Green }
