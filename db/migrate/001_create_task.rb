class CreateTask < ActiveRecord::Migration

  def self.up

    create_table :task do |t|
      t.column :task_name, :string, {:limit => 256,:null => false}
      t.column :description, :string, {:limit => 1024}
      t.column :status, :string, {:limit => 32}
      t.column :taskname, :string, {:limit => 64,:null => false}
      t.column :failurereason, :string, {:limit => 256}
      t.column :cur_action_id, :integer
      t.column :chaingang_id, :integer
      t.column :is_deleted, :string, {:limit => 1,:default => 'N'}
      t.column :start_by, :date
      t.column :task_group, :string, {:limit => 32}
      t.column :mapper, :string, {:limit => 4000}
      t.column :processed, :integer
      t.column :parent_task_id, :integer
      t.column :is_parent, :string, {:limit => 1,:default => 'N'}
      t.column :timeout_secs, :integer
      t.timestamps

    end

    ["alter table task rename column id to task_id",
     "alter table task
      add constraint task_ckc1 check ( status in ('new','analyzing', 'waiting', 'starting', 'started','running', 'succeeded','failed','recovering', 'finished','retry','error','queued','cancel','canceled','killed'))"].each do |sql|
      execute sql
    end

    add_index(:task, :task_name, {:unique => true})
    add_index(:task,[:task_id, :cur_action_id], {:name => :task_ta})

    execute MigrationHelpers.fk_generate(:table => :task,
                                 :refers_to => :task,
                                 :from => :parent_task_id,
                                 :to => :task_id)
  end
  def self.down
    drop_table :task

  end
end
