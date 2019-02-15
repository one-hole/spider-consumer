require 'rubygems'
require 'pry'

Dir[File.dirname(__FILE__) + "/models/*.rb"].map { |file| require file }
Dir[File.dirname(__FILE__) + "/middlewares/*.rb"].map { |file| require file }

require_relative "config/config"
require_relative "work_pool"

hltv = Hltv.new
WorkPool.instance

puts '-------------'

binding.pry
