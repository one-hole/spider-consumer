require 'rubygems'
require 'pry'
require 'thwait'

Dir[File.dirname(__FILE__) + "/models/*.rb"].map { |file| require file }
Dir[File.dirname(__FILE__) + "/models/matches/*.rb"].map { |file| require file }
Dir[File.dirname(__FILE__) + "/middlewares/*.rb"].map { |file| require file }

require_relative "config/config"

hltv = Hltv.new
WorkPool.instance

ThreadsWait.all_waits(*WorkPool.instance.threads)
