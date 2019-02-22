require "rubygems"
require "redis"

# TODO 这里可以引入连接池用来节省资源建立和释放的成本
module Middlewares

  @@redis_client = nil

  def self.redis_client
    @@redis_client ||= Redis.new(
      # connect_timeout: 10,
      # read_timeout:    60,
      host:            "127.0.0.1",
      port:            "6379",
      db:              12,
      reconnect_attempts:  10,
      reconnect_delay:     2,
      reconnect_delay_max: 10.0
    )
  end

  def self.hltv_consumer
  end
end
