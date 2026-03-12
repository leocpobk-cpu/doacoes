// Supabase Edge Function - Notificação Telegram
// Deploy: supabase functions deploy notificar-telegram

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

const TELEGRAM_BOT_TOKEN = Deno.env.get('TELEGRAM_BOT_TOKEN')!
const TELEGRAM_CHAT_ID = Deno.env.get('TELEGRAM_CHAT_ID')!

serve(async (req) => {
  try {
    const { record, type, table } = await req.json()

    // Verifica se é uma nova doação
    if (table !== 'doacoes' || type !== 'INSERT') {
      return new Response('OK', { status: 200 })
    }

    // Busca dados do item doado
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    
    const itemResponse = await fetch(
      `${supabaseUrl}/rest/v1/itens_doacao?id=eq.${record.item_id}&select=*`,
      {
        headers: {
          'apikey': supabaseKey,
          'Authorization': `Bearer ${supabaseKey}`
        }
      }
    )
    
    const items = await itemResponse.json()
    const item = items[0]

    // Monta mensagem
    let mensagem = `🎁 NOVA DOAÇÃO!\n\n`
    mensagem += `👤 Doador: ${record.doador_nome}`
    
    if (record.doador_regiao) {
      mensagem += ` (${record.doador_regiao})`
    }
    
    mensagem += `\n📦 Item: ${item.descricao}`
    
    if (record.tipo_doacao === 'dinheiro') {
      mensagem += `\n💰 Valor: R$ ${parseFloat(record.valor_dinheiro).toFixed(2)}`
      if (record.quantidade) {
        mensagem += `\n📊 Equivale a: ${record.quantidade} ${item.unidade}`
      }
    } else {
      mensagem += `\n📊 Quantidade: ${record.quantidade} ${item.unidade}`
    }
    
    if (record.observacao) {
      mensagem += `\n📝 Obs: ${record.observacao}`
    }
    
    mensagem += `\n\n⏰ ${new Date(record.criado_em).toLocaleString('pt-BR')}`

    // Envia para Telegram
    const telegramUrl = `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`
    
    await fetch(telegramUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        chat_id: TELEGRAM_CHAT_ID,
        text: mensagem,
        parse_mode: 'HTML'
      })
    })

    return new Response('Notificação enviada!', { status: 200 })
    
  } catch (error) {
    console.error('Erro:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    })
  }
})
