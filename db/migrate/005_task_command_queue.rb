class TaskCommandQueue < ActiveRecord::Migration

  def self.up
    create_table :task_command_queue do |t|
      t.column :command, :string,{:limit => 4000}
      t.column :result_code, :integer
      t.column :result_message, :string,{:limit => 512}
      t.column :is_processed, :string,{:limit => 1}
      t.column :at_time, :date
      t.column :task_id, :integer
      t.column :action_id, :integer
      t.column :is_deleted, :string,{:limit => 1}
      t.timestamps
    end

    execute "alter table task_command_queue rename column id to task_command_queue_id"
    
    execute MigrationHelpers.fk_generate(:table => :task_command_queue,
                                         :refers_to => :task,
                                         :from => :task_id,
                                         :to => :task_id)
  end

  
 
  def self.down
    drop_table :task_command_queue
  end
end
