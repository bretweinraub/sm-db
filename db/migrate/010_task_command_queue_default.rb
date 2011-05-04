class TaskCommandQueueDefault < ActiveRecord::Migration

  def self.up
    change_column :task_command_queue, :is_processed, :string,{:limit => 1, :null => false, :default => 'N'}
  end
  
 
  def self.down
    change_column :task_command_queue, :is_processed, :string,{:limit => 1}
  end
end
