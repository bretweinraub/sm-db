#!/usr/bin/env ruby

module Oracle
  def self.type_to_active_record col
    limit = nil
    t = nil
    case col.data_type
    when "NUMBER"
      t = "integer"
    when "VARCHAR2"
      t= "string"
      limit = col.data_length
    when "DATE"
      t = "date"
    else
      raise "not impl #{col.data_type}"
    end
    ret = "#{t}"
    terms = 0
    if limit or col.nullable == "N" or ! col.data_default.nil?
      ret += ", {"
      if limit
        terms += 1
        ret += ":limit => #{limit.to_i}"
      end
      if col.nullable == "N"
        ret += "," if terms > 0
        terms += 1
        ret += ":null => false"
      end
      if ! col.data_default.nil?
        ret += "," if terms > 0
        terms += 1
        ret += ":default => #{col.data_default.chomp}"
      end
      ret += "}"
    end
    ret
  end
end

RAILS_ENV="aura-di"

require File.join(File.dirname(__FILE__),'config','boot.rb')

ActiveRecord::Base.establish_connection(DB_CONFIG[ENVIRONMENT])

table_name="task"

class UserTabColumn < ActiveRecord::Base

end

cols = UserTabColumn.find_by_sql("
select column_name,data_type,data_type_mod,data_default,data_length,data_scale,data_precision,nullable from user_tab_columns where table_name = '#{table_name.upcase}'
")

puts <<"EOF"

class #{table_name.camelize} < ActiveRecord::Migration

  def self.up
    create_table :#{table_name} do |t|
EOF

    cols.each do |col|
      next if [:inserted_dt,:updated_dt].include? col.column_name.downcase.to_sym
      next if col.column_name.downcase == "#{table_name.downcase}_id"
      puts <<"EOF"
      t.column :#{col.column_name.downcase}, :#{Oracle.type_to_active_record(col)}
EOF
    end
      
    

puts <<"EOF"
      t.timestamps
    end
    execute "alter table #{table_name} rename column id to #{table_name}_id"
  end
 
  def self.down
    drop_table :#{table_name}
  end
end
EOF
    


