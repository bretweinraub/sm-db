DROP TRIGGER IF EXISTS task_create ON task;
CREATE TRIGGER task_create
BEFORE insert ON task
FOR EACH ROW EXECUTE PROCEDURE timestamp_insert();
