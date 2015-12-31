tables = ActiveRecord::Base.connection.tables - ["schema_migrations", "proc"]

tables.each do |model_table_name|
  model_class = Class.new(ActiveRecord::Base) do
    self.table_name = model_table_name
  end

  Object.const_set(model_table_name.camelize, model_class)
end

class ProcModel < ActiveRecord::Base
  self.table_name = "proc"
end
