// Supabase Edge Function - Bot Telegram com Comandos
// Deploy: supabase functions deploy telegram-bot

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const TELEGRAM_TOKEN = Deno.env.get('TELEGRAM_BOT_TOKEN')!
const supabaseUrl = Deno.env.get('SUPABASE_URL')!
const supabaseKey = Deno.env.get('SUPABASE_ANON_KEY')!

const supabase = createClient(supabaseUrl, supabaseKey)

serve(async (req) => {
  try {
    console.log('Recebeu requisicao')
    const body = await req.json()
    console.log('Body:', JSON.stringify(body))
    
    const { message } = body
    
    if (!message || !message.text) {
      console.log('Sem mensagem ou texto')
      return new Response('OK', { status: 200 })
    }

    const chatId = message.chat.id
    const text = message.text.toLowerCase().trim()
    console.log(`Chat ID: ${chatId}, Texto: ${text}`)
    
    let resposta = ''

    // Processa comandos
    if (text === '/start' || text === '/help') {
      resposta = `🍓 *Feira Gastronômica COOPHAMIL*

Comandos disponíveis:

/status - Resumo geral das doações
/itens - Lista completa com progresso
/faltam - Apenas itens pendentes
/ultimas - Últimos 5 lançamentos
/doar - Link para fazer doação
/help - Ver comandos

💡 *Doações em tempo real!*
Você receberá notificações automáticas a cada nova doação.`
    }
    else if (text === '/status') {
      resposta = await getStatus()
    }
    else if (text === '/itens') {
      resposta = await getItensCompleto()
    }
    else if (text === '/faltam') {
      resposta = await getItensPendentes()
    }
    else if (text === '/ultimas') {
      resposta = await getUltimasDoacao()
    }
    else if (text === '/doar') {
      resposta = `💝 *Como Doar para a Feira Gastronômica*

🌐 Acesse o sistema:
https://leocpobk-cpu.github.io/doacoes/

📱 PIX para doações em dinheiro:
*Chave:* leocpo@gmail.com
*Favorecido:* Leonardo Cezario Pinto de Oliveira

🍎 Frutas e ingredientes:
Veja a lista completa com /itens

✅ Após doar, registre no sistema para atualizarmos a lista!`
    }
    else {
      console.log('Comando nao reconhecido')
      return new Response('OK', { status: 200 })
    }

    // Envia resposta
    console.log('Enviando resposta para', chatId)
    console.log('Resposta:', resposta.substring(0, 100))
    
    const telegramResponse = await fetch(`https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        chat_id: chatId,
        text: resposta,
        parse_mode: 'Markdown'
      })
    })
    
    const telegramData = await telegramResponse.json()
    console.log('Resposta do Telegram:', JSON.stringify(telegramData))

    return new Response('OK', { status: 200 })
  } catch (error) {
    console.error('Erro:', error)
    console.error('Stack:', error.stack)
    return new Response('OK', { status: 200 })
  }
})

// Função: Status Geral
async function getStatus() {
  const { data: itens } = await supabase.from('itens_doacao').select('*')
  const { data: doacoes } = await supabase.from('doacoes').select('*')
  
  if (!itens || !doacoes) return '❌ Erro ao buscar dados'
  
  const completos = itens.filter(item => {
    const doado = doacoes
      .filter(d => d.item_id === item.id)
      .reduce((sum, d) => sum + parseFloat(d.quantidade || 0), 0)
    return doado >= parseFloat(item.quantidade_total)
  }).length
  
  const pendentes = itens.filter(item => {
    const doado = doacoes
      .filter(d => d.item_id === item.id)
      .reduce((sum, d) => sum + parseFloat(d.quantidade || 0), 0)
    return doado === 0
  }).length
  
  const doadores = new Set(doacoes.map(d => d.doador_nome)).size
  
  const dinheiro = doacoes
    .filter(d => d.tipo_doacao === 'dinheiro')
    .reduce((sum, d) => sum + parseFloat(d.valor_dinheiro || 0), 0)
  
  const parciais = itens.length - completos - pendentes
  
  return `📊 *RESUMO DAS DOAÇÕES*

✅ *${completos}* itens completos
🔄 *${parciais}* itens em andamento  
⏳ *${pendentes}* itens pendentes

👥 *${doadores}* doadores
💰 R$ *${dinheiro.toFixed(2)}* arrecadados

Total: ${itens.length} itens

Use /itens para ver detalhes`
}

// Função: Lista Completa
async function getItensCompleto() {
  const { data: itens } = await supabase.from('itens_doacao').select('*').order('id')
  const { data: doacoes } = await supabase.from('doacoes').select('*')
  
  if (!itens || !doacoes) return '❌ Erro ao buscar dados'
  
  let msg = '📋 *LISTA COMPLETA*\n\n'
  
  itens.forEach((item, idx) => {
    const doado = doacoes
      .filter(d => d.item_id === item.id)
      .reduce((sum, d) => sum + parseFloat(d.quantidade || 0), 0)
    
    const total = parseFloat(item.quantidade_total)
    const percentual = Math.min((doado / total) * 100, 100).toFixed(0)
    const falta = Math.max(total - doado, 0)
    
    let emoji = '⏳'
    if (percentual >= 100) emoji = '✅'
    else if (percentual >= 70) emoji = '🟢'
    else if (percentual >= 40) emoji = '🟡'
    else if (percentual > 0) emoji = '🔴'
    
    msg += `${emoji} ${idx + 1}. ${item.descricao}\n`
    msg += `   ${doado}/${total} ${item.unidade} (${percentual}%)\n`
    if (falta > 0) {
      msg += `   Faltam: ${falta.toFixed(1)} ${item.unidade}\n`
    }
    msg += '\n'
  })
  
  msg += 'Use /doar para contribuir!'
  
  return msg
}

// Função: Apenas Pendentes
async function getItensPendentes() {
  const { data: itens } = await supabase.from('itens_doacao').select('*').order('id')
  const { data: doacoes } = await supabase.from('doacoes').select('*')
  
  if (!itens || !doacoes) return '❌ Erro ao buscar dados'
  
  let msg = '⏳ *ITENS PENDENTES*\n\n'
  let count = 0
  
  itens.forEach((item, idx) => {
    const doado = doacoes
      .filter(d => d.item_id === item.id)
      .reduce((sum, d) => sum + parseFloat(d.quantidade || 0), 0)
    
    const total = parseFloat(item.quantidade_total)
    const falta = total - doado
    
    if (falta > 0) {
      count++
      const percentual = ((doado / total) * 100).toFixed(0)
      
      msg += `${idx + 1}. ${item.descricao}\n`
      msg += `   Faltam: *${falta.toFixed(1)} ${item.unidade}*\n`
      if (doado > 0) {
        msg += `   Progresso: ${percentual}%\n`
      }
      msg += '\n'
    }
  })
  
  if (count === 0) {
    msg = '🎉 *PARABÉNS!*\n\nTodas as doações foram completadas!'
  } else {
    msg += `Total: ${count} itens precisando de doações\n\n`
    msg += 'Use /doar para contribuir!'
  }
  
  return msg
}

// Função: Últimas Doações
async function getUltimasDoacao() {
  const { data: doacoes } = await supabase
    .from('doacoes')
    .select('*, itens_doacao(descricao, unidade)')
    .order('data_doacao', { ascending: false })
    .limit(5)
  
  if (!doacoes || doacoes.length === 0) return '📭 Ainda não há doações registradas'
  
  let msg = '🕒 *ÚLTIMAS DOAÇÕES*\n\n'
  
  doacoes.forEach((doacao, idx) => {
    const data = new Date(doacao.data_doacao)
    const dataFormatada = data.toLocaleDateString('pt-BR', { 
      day: '2-digit', 
      month: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    })
    
    msg += `${idx + 1}. *${doacao.doador_nome}*\n`
    
    if (doacao.tipo_doacao === 'dinheiro') {
      msg += `   💰 R$ ${parseFloat(doacao.valor_dinheiro).toFixed(2)}\n`
      if (doacao.itens_doacao) {
        msg += `   Equiv.: ${doacao.quantidade} ${doacao.itens_doacao.unidade} de ${doacao.itens_doacao.descricao}\n`
      }
    } else {
      msg += `   📦 ${doacao.quantidade} ${doacao.itens_doacao?.unidade || ''} de ${doacao.itens_doacao?.descricao || 'item'}\n`
    }
    
    msg += `   🕐 ${dataFormatada}\n\n`
  })
  
  msg += 'Use /doar para contribuir!'
  
  return msg
}
