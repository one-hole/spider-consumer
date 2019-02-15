require 'active_record'
require 'yaml'

class BaseRecord < ActiveRecord::Base
  self.abstract_class = true
  @db ||= YAML.load_file(File.join("config", "database.yml"))[ENV["APP_ENV"]]
  ActiveRecord::Base.establish_connection @db
end
