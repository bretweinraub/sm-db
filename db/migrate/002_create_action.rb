class CreateAction < ActiveRecord::Migration
  def self.up

    create_table :action do |t|
      t.column :export_filter, :string, {:limit => 512}
      t.column :callbacks, :string, {:limit => 4000}
      t.column :actionmapper, :string, {:limit => 4000}
      t.column :actionname, :string, {:limit => 256}
      t.column :numfailures, :integer, {:default => 0}
      t.column :actionstatus, :string, {:limit => 32}
      t.column :actionpid, :integer
      t.column :outputurl, :string, {:limit => 256}
      t.column :actionsequence, :integer, {:null => false}
      t.column :task_id, :integer
      t.column :is_deleted, :string, {:limit => 1,:default => 'N'}
      t.timestamps
    end

    ["alter table action rename column id to action_id",
     "alter table action add constraint action_ckc1 check ( actionstatus in ('new','analyzing', 'waiting', 'starting', 'started','running', 'succeeded','failed','recovering', 'finished','retry','error','queued','cancel','canceled','killed'))"
    ].each do |sql|
      execute sql
    end

    execute MigrationHelpers.fk_generate(:table => :action,
                                         :refers_to => :task,
                                         :from => :task_id,
                                         :to => :task_id)

    add_index(:action, [:task_id,:action_id])

  end
  def self.down
    drop_table :action
  end
  
end
