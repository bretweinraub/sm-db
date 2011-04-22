DROP TRIGGER IF EXISTS task_command_queue_update ON task_command_queue;
CREATE TRIGGER task_command_queue_update
BEFORE update ON task_command_queue
FOR EACH ROW EXECUTE PROCEDURE timestamp_update();
