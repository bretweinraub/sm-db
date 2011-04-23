class CreateTaskTemplates < ActiveRecord::Migration
  def self.up

    create_table :task_templates do |t|
      t.string :name , :null => false
      t.string :task, :null => false
      t.timestamps
    end

    create_table :template_contexts do |t|
      t.string :tag, :null => false
      t.string :value
      t.integer :task_template_id
      t.timestamps
    end
  end

  def self.down
    drop_table :task_templates
    drop_table :template_contexts
  end
end
