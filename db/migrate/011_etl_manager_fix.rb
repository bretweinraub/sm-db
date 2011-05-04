class EtlManagerFix < ActiveRecord::Migration

  def self.up
    change_column :etlmanager, :last_update, :timestamp

  end

 
  def self.down
    change_column :etlmanager, :last_update, :date
  end
end
