#!/usr/bin/env ruby

[:task,:action,:task_context,:task_command_queue].each do |table|
  table_name = table.to_s

  f=File.open("db/triggers/#{table_name}_create.sql", "w")

  f.write <<"EOF"
DROP TRIGGER IF EXISTS #{table_name}_create ON #{table_name};
CREATE TRIGGER #{table_name}_create
BEFORE insert ON #{table_name}
FOR EACH ROW EXECUTE PROCEDURE timestamp_insert();
EOF


  f=File.open("db/triggers/#{table_name}_update.sql", "w")

  f.write <<"EOF"
DROP TRIGGER IF EXISTS #{table_name}_update ON #{table_name};
CREATE TRIGGER #{table_name}_update
BEFORE update ON #{table_name}
FOR EACH ROW EXECUTE PROCEDURE timestamp_update();
EOF
end
