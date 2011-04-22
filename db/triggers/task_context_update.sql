DROP TRIGGER IF EXISTS task_context_update ON task_context;
CREATE TRIGGER task_context_update
BEFORE update ON task_context
FOR EACH ROW EXECUTE PROCEDURE timestamp_update();
