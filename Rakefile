# -*-ruby-*- 

require File.join(File.dirname(__FILE__), "config", "boot.rb")

task :default => :migrate
desc "Migrate the database through scripts in db/migrate. Target a specific migration with VERSION=x"

task :environment do
  ActiveRecord::Base.logger = Logger.new("database.log")
end

module ActiveRecord
  class Migrator
    class << self
      def schema_migrations_table_name
        "sm_db_" + 'schema_migrations'
      end
    end
  end
end

namespace :db do 
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate("db/migrate", ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end

namespace :db do
  task :compile => 'environment' do
    desc "Compile Objects"
    require 'dbcompile'
    DbCompile.build_transaction
  end
end
