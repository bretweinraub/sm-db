module MigrationHelpers
  
  def self.fk_generate(h={})
    table = h[:table] || raise("set :table in #{current_method}")
    refers_to = h[:refers_to] || raise("set :refers_to in #{current_method}")
    from = h[:from] || raise("set :from in #{current_method}")
    to = h[:to] || raise("set :to in #{current_method}")

    "ALTER TABLE #{table} ADD CONSTRAINT #{table}_fk_#{refers_to}_#{to} FOREIGN KEY (#{from}) REFERENCES #{refers_to}(#{to})"
  end

  def self.drop_fk(h={})
    table = h[:table] || raise("set :table in #{current_method}")
    refers_to = h[:refers_to] || raise("set :refers_to in #{current_method}")
    from = h[:from] || raise("set :from in #{current_method}")
    to = h[:to] || raise("set :to in #{current_method}")

    "alter table #{table} DROP CONSTRAINT #{table}_fk_#{refers_to}_#{to}"
  end
end
