DROP TRIGGER IF EXISTS action_create ON action;
CREATE TRIGGER action_create
BEFORE insert ON action
FOR EACH ROW EXECUTE PROCEDURE timestamp_insert();
