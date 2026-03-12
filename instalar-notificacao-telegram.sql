-- ============================================
-- NOTIFICAÇÃO TELEGRAM - TRIGGER DIRETO
-- Execute no SQL Editor do Supabase
-- ============================================

-- 1. Habilitar extensão pg_net (HTTP requests)
CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

-- 2. Criar função que envia notificação
CREATE OR REPLACE FUNCTION notificar_telegram_doacao()
RETURNS TRIGGER AS $$
DECLARE
    item_info RECORD;
    mensagem TEXT;
    telegram_url TEXT;
    telegram_token TEXT := '8499578188:AAHNGisnOYoHGNK7b7WLmD12hmIpbdCr5xQ';
    chat_id TEXT := '7874363619';
BEGIN
    -- Busca informações do item
    SELECT descricao, unidade 
    INTO item_info
    FROM itens_doacao 
    WHERE id = NEW.item_id;
    
    -- Monta mensagem
    mensagem := E'🎁 NOVA DOAÇÃO!\n\n';
    mensagem := mensagem || '👤 Doador: ' || NEW.doador_nome;
    
    IF NEW.doador_regiao IS NOT NULL THEN
        mensagem := mensagem || ' (' || NEW.doador_regiao || ')';
    END IF;
    
    mensagem := mensagem || E'\n📦 Item: ' || item_info.descricao;
    
    IF NEW.tipo_doacao = 'dinheiro' THEN
        mensagem := mensagem || E'\n💰 Valor: R$ ' || ROUND(NEW.valor_dinheiro::numeric, 2);
        IF NEW.quantidade IS NOT NULL THEN
            mensagem := mensagem || E'\n📊 Equivale a: ' || NEW.quantidade || ' ' || item_info.unidade;
        END IF;
    ELSE
        mensagem := mensagem || E'\n📊 Quantidade: ' || NEW.quantidade || ' ' || item_info.unidade;
    END IF;
    
    IF NEW.observacao IS NOT NULL THEN
        mensagem := mensagem || E'\n📝 Obs: ' || NEW.observacao;
    END IF;
    
    mensagem := mensagem || E'\n\n⏰ ' || TO_CHAR(NEW.criado_em, 'DD/MM/YYYY HH24:MI:SS');
    
    -- Envia para Telegram
    telegram_url := 'https://api.telegram.org/bot' || telegram_token || '/sendMessage';
    
    PERFORM net.http_post(
        url := telegram_url,
        body := jsonb_build_object(
            'chat_id', chat_id,
            'text', mensagem
        )
    );
    
    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        -- Em caso de erro, apenas registra no log mas não falha a transação
        RAISE WARNING 'Erro ao enviar notificação Telegram: %', SQLERRM;
        RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Criar trigger
DROP TRIGGER IF EXISTS trigger_notificar_telegram ON doacoes;

CREATE TRIGGER trigger_notificar_telegram
    AFTER INSERT ON doacoes
    FOR EACH ROW
    EXECUTE FUNCTION notificar_telegram_doacao();

-- 4. Verificação
SELECT 'Trigger criado! Teste fazendo uma doacao no sistema' as status;
