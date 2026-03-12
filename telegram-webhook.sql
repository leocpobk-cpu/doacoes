-- ============================================
-- WEBHOOK TELEGRAM - NOTIFICAÇÃO DE DOAÇÕES
-- ============================================

-- Criando Database Webhook para chamar a Edge Function
-- Execute isso no Supabase SQL Editor após fazer deploy da função

CREATE OR REPLACE FUNCTION notify_telegram_on_donation()
RETURNS TRIGGER AS $$
DECLARE
  payload JSON;
BEGIN
  -- Prepara dados para enviar
  payload := json_build_object(
    'type', TG_OP,
    'table', TG_TABLE_NAME,
    'record', row_to_json(NEW)
  );

  -- Chama a Edge Function via HTTP
  PERFORM
    net.http_post(
      url := 'https://fwmlimudntlrkeukvyjg.supabase.co/functions/v1/notificar-telegram',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || current_setting('app.settings.service_role_key')
      )::jsonb,
      body := payload::jsonb
    );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Cria trigger que dispara quando há INSERT na tabela doacoes
DROP TRIGGER IF EXISTS telegram_notification_trigger ON doacoes;

CREATE TRIGGER telegram_notification_trigger
  AFTER INSERT ON doacoes
  FOR EACH ROW
  EXECUTE FUNCTION notify_telegram_on_donation();

-- ============================================
-- VERIFICAÇÃO
-- ============================================

SELECT 'Trigger criado com sucesso!' as status;
