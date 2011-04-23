class EtlManager < ActiveRecord::Migration

  def self.up
    create_table :etlmanager do |t|
      t.column :etlmanager_name, :string, {:limit => 64,:null => false}
      t.column :description, :string, {:limit => 1024}
      t.column :last_update, :date
      t.column :num_errors, :integer, {:default => 0}
      t.column :is_deleted, :string, {:limit => 1,:default => 'N'
                }
      t.timestamps
    end
    execute "alter table etlmanager rename column id to etlmanager_id"

    add_index(:etlmanager,:etlmanager_name,{:unique => true})
  end

 
  def self.down
    drop_table :etlmanager
  end
end
