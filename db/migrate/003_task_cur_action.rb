class TaskCurAction < ActiveRecord::Migration

  def self.up
    execute MigrationHelpers.fk_generate(:table => :task,
                                         :refers_to => :action,
                                         :from => :cur_action_id,
                                         :to => :action_id)

  end

  def self.down
    execute MigrationHelpers.drop_fk(:table => :task,
                                     :refers_to => :action,
                                     :from => :cur_action_id,
                                     :to => :action_id)
  end
end
