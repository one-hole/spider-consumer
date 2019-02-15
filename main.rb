require 'rubygems'
require 'pry'
require_relative "models/match"
require_relative "config/config"
require_relative "work_pool"
require_relative "middlewares/redis"

match = Match.new
config = Config.new

class Task
  def call
    puts "+++++-"
  end
end

task = Task.new

WorkPool.add(task)

puts '-------------'

binding.pry
