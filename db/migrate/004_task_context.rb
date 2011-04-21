class TaskContext < ActiveRecord::Migration

  def self.up
    create_table :task_context do |t|
      t.column :tag, :string, {:limit => 256}
      t.column :value, :string, {:limit => 4000}
      t.column :source, :string, {:limit => 512}
      t.column :type, :string, {:limit => 64}
      t.column :host, :string, {:limit => 64}
      t.column :is_deleted, :string, {:limit => 1, :default => 'N'}
      t.column :group_name, :string, {:limit => 64}
      t.column :uniqueness, :string, {:limit => 64}
      t.column :parent_task_context_id, :integer
      t.column :task_id, :integer
      t.timestamps
    end

    add_index(:task_context,:task_id)

    execute "alter table task_context rename column id to task_context_id"

    execute MigrationHelpers.fk_generate(:table => :task_context,
                                         :refers_to => :task,
                                         :from => :task_id,
                                         :to => :task_id)

    execute MigrationHelpers.fk_generate(:table => :task_context,
                                         :refers_to => :task_context,
                                         :from => :parent_task_context_id,
                                         :to => :task_context_ID)


  end

  def self.down
    drop_table :task_context
  end
end
