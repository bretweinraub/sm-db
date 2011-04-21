DROP TRIGGER IF EXISTS task_update ON task;
CREATE TRIGGER task_update
BEFORE update ON task
FOR EACH ROW EXECUTE PROCEDURE timestamp_update();
