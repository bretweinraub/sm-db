class ScriptInfo < ActiveRecord::Migration
  def self.up
    create_table :script_info do |t|
      t.string  :name
      t.text :full_path 
      t.text :lock_file
      t.text  :arguments
      t.integer :pid 
      t.integer :process_group
      t.timestamps
    end

  end

  def self.down
    drop_table :script_info
  end
end
