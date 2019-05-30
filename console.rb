require 'rubygems'
require 'pry'

Dir[File.dirname(__FILE__) + "/models/*.rb"].map { |file| require file }
Dir[File.dirname(__FILE__) + "/models/matches/*.rb"].map { |file| require file }
Dir[File.dirname(__FILE__) + "/middlewares/*.rb"].map { |file| require file }

require_relative "config/config"

binding.pry