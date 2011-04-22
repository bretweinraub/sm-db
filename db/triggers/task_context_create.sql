DROP TRIGGER IF EXISTS task_context_create ON task_context;
CREATE TRIGGER task_context_create
BEFORE insert ON task_context
FOR EACH ROW EXECUTE PROCEDURE timestamp_insert();
