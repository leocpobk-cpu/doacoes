# Script para Atualizar para a Feira Gastronômica COOPHAMIL
# Execute este script para fazer a transição completa

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "🍓 FEIRA GASTRONÔMICA COOPHAMIL" -ForegroundColor Green
Write-Host "Atualização do Sistema de Doações" -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Cyan

# Verificar se Supabase CLI está instalado
Write-Host "1. Verificando Supabase CLI..." -ForegroundColor Cyan
try {
    $supabaseVersion = supabase --version 2>$null
    if ($supabaseVersion) {
        Write-Host "✅ Supabase CLI encontrado: $supabaseVersion`n" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Supabase CLI não encontrado!" -ForegroundColor Red
    Write-Host "   Instale com: npm install -g supabase" -ForegroundColor Yellow
    Write-Host "   Ou baixe de: https://supabase.com/docs/guides/cli`n" -ForegroundColor Yellow
}

# Menu de opções
Write-Host "`nO que você deseja fazer?" -ForegroundColor Cyan
Write-Host "1 - Atualizar banco de dados (executar SQL)" -ForegroundColor White
Write-Host "2 - Deploy do bot Telegram" -ForegroundColor White
Write-Host "3 - Configurar webhook Telegram" -ForegroundColor White
Write-Host "4 - Fazer tudo (1 + 2 + 3)" -ForegroundColor White
Write-Host "5 - Ver status atual" -ForegroundColor White
Write-Host "0 - Sair`n" -ForegroundColor White

$opcao = Read-Host "Escolha uma opção"

switch ($opcao) {
    "1" {
        Write-Host "`n✅ Opção 1: Atualizar Banco de Dados" -ForegroundColor Green
        Write-Host "----------------------------------------" -ForegroundColor Gray
        Write-Host "📋 Arquivo SQL: setup-feira-gastronomica-coophamil.sql`n" -ForegroundColor Yellow
        
        Write-Host "Instruções:" -ForegroundColor Cyan
        Write-Host "1. Acesse: https://supabase.com/dashboard" -ForegroundColor White
        Write-Host "2. Selecione seu projeto" -ForegroundColor White
        Write-Host "3. Vá em: SQL Editor (menu lateral)" -ForegroundColor White
        Write-Host "4. Clique em: New Query" -ForegroundColor White
        Write-Host "5. Cole o conteúdo do arquivo SQL" -ForegroundColor White
        Write-Host "6. Clique em: Run`n" -ForegroundColor White
        
        $abrirArquivo = Read-Host "Deseja abrir o arquivo SQL agora? (S/N)"
        if ($abrirArquivo -eq "S" -or $abrirArquivo -eq "s") {
            notepad "setup-feira-gastronomica-coophamil.sql"
        }
        
        $abrirSupabase = Read-Host "Deseja abrir o Supabase Dashboard? (S/N)"
        if ($abrirSupabase -eq "S" -or $abrirSupabase -eq "s") {
            Start-Process "https://supabase.com/dashboard"
        }
    }
    
    "2" {
        Write-Host "`n✅ Opção 2: Deploy do Bot Telegram" -ForegroundColor Green
        Write-Host "----------------------------------------" -ForegroundColor Gray
        
        try {
            Write-Host "`nExecutando deploy..." -ForegroundColor Cyan
            supabase functions deploy telegram-bot
            
            Write-Host "`n✅ Deploy concluído!`n" -ForegroundColor Green
            Write-Host "⚠️ Não esqueça de configurar as variáveis de ambiente:" -ForegroundColor Yellow
            Write-Host "   - TELEGRAM_BOT_TOKEN" -ForegroundColor White
            Write-Host "   - SUPABASE_URL" -ForegroundColor White
            Write-Host "   - SUPABASE_ANON_KEY`n" -ForegroundColor White
            
            $abrirConfig = Read-Host "Deseja abrir configurações do Supabase? (S/N)"
            if ($abrirConfig -eq "S" -or $abrirConfig -eq "s") {
                Start-Process "https://supabase.com/dashboard/project/_/settings/functions"
            }
        } catch {
            Write-Host "`n❌ Erro no deploy!" -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor Red
        }
    }
    
    "3" {
        Write-Host "`n✅ Opção 3: Configurar Webhook Telegram" -ForegroundColor Green
        Write-Host "----------------------------------------" -ForegroundColor Gray
        
        if (Test-Path ".\configurar-webhook-telegram.ps1") {
            Write-Host "`nExecutando script de configuração...`n" -ForegroundColor Cyan
            .\configurar-webhook-telegram.ps1
        } else {
            Write-Host "❌ Arquivo configurar-webhook-telegram.ps1 não encontrado!" -ForegroundColor Red
        }
    }
    
    "4" {
        Write-Host "`n✅ Opção 4: Fazer Tudo" -ForegroundColor Green
        Write-Host "========================================`n" -ForegroundColor Gray
        
        # Passo 1: SQL
        Write-Host "📋 PASSO 1: Banco de Dados" -ForegroundColor Cyan
        Write-Host "Abra o arquivo SQL e execute no Supabase:" -ForegroundColor Yellow
        notepad "setup-feira-gastronomica-coophamil.sql"
        Start-Process "https://supabase.com/dashboard"
        Read-Host "`nPressione ENTER após executar o SQL..."
        
        # Passo 2: Deploy
        Write-Host "`n🚀 PASSO 2: Deploy do Bot" -ForegroundColor Cyan
        try {
            supabase functions deploy telegram-bot
            Write-Host "✅ Deploy concluído!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Erro no deploy: $($_.Exception.Message)" -ForegroundColor Red
        }
        
        # Passo 3: Webhook
        Write-Host "`n🔗 PASSO 3: Webhook Telegram" -ForegroundColor Cyan
        if (Test-Path ".\configurar-webhook-telegram.ps1") {
            .\configurar-webhook-telegram.ps1
        }
        
        Write-Host "`n========================================" -ForegroundColor Cyan
        Write-Host "✅ CONFIGURAÇÃO COMPLETA!" -ForegroundColor Green
        Write-Host "========================================`n" -ForegroundColor Cyan
    }
    
    "5" {
        Write-Host "`n📊 Status do Sistema" -ForegroundColor Green
        Write-Host "----------------------------------------" -ForegroundColor Gray
        
        Write-Host "`n📁 Arquivos:" -ForegroundColor Cyan
        $arquivos = @(
            "setup-feira-gastronomica-coophamil.sql",
            "supabase\functions\telegram-bot\index.ts",
            "docs\index-supabase.html",
            "README-FEIRA-GASTRONOMICA.md"
        )
        
        foreach ($arquivo in $arquivos) {
            if (Test-Path $arquivo) {
                Write-Host "   ✅ $arquivo" -ForegroundColor Green
            } else {
                Write-Host "   ❌ $arquivo (não encontrado)" -ForegroundColor Red
            }
        }
        
        Write-Host "`n🔧 Ferramentas:" -ForegroundColor Cyan
        try {
            $supabaseVer = supabase --version 2>$null
            Write-Host "   ✅ Supabase CLI: $supabaseVer" -ForegroundColor Green
        } catch {
            Write-Host "   ❌ Supabase CLI (não instalado)" -ForegroundColor Red
        }
        
        Write-Host "`n💡 Próximos Passos:" -ForegroundColor Yellow
        Write-Host "   1. Execute o SQL no Supabase" -ForegroundColor White
        Write-Host "   2. Faça deploy do bot" -ForegroundColor White
        Write-Host "   3. Configure o webhook" -ForegroundColor White
        Write-Host "   4. Publique a página HTML`n" -ForegroundColor White
    }
    
    "0" {
        Write-Host "`n👋 Até logo!" -ForegroundColor Cyan
        exit
    }
    
    default {
        Write-Host "`n❌ Opção inválida!" -ForegroundColor Red
    }
}

Write-Host "`n📚 Documentação completa em: README-FEIRA-GASTRONOMICA.md" -ForegroundColor Cyan
Write-Host "🌐 Site: https://leocpobk-cpu.github.io/doacoes/" -ForegroundColor Cyan
Write-Host "💰 PIX: leocpo@gmail.com`n" -ForegroundColor Green

Read-Host "Pressione ENTER para sair"
