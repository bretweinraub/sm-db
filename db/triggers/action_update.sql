DROP TRIGGER IF EXISTS action_update ON action;
CREATE TRIGGER action_update
BEFORE update ON action
FOR EACH ROW EXECUTE PROCEDURE timestamp_update();
