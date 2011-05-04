class TaskCommandQueueFix < ActiveRecord::Migration

  def self.up
    change_column :task_command_queue, :at_time, :timestamp, {:null => false}

  end
  
 
  def self.down
    change_column :task_command_queue, :at_time, :date
  end
end
