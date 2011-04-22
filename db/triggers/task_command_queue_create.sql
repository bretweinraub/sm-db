DROP TRIGGER IF EXISTS task_command_queue_create ON task_command_queue;
CREATE TRIGGER task_command_queue_create
BEFORE insert ON task_command_queue
FOR EACH ROW EXECUTE PROCEDURE timestamp_insert();
