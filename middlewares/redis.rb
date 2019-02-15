require "rubygems"
require "redis"

# TODO 这里可以引入连接池用来节省资源建立和释放的成本
module Middlewares

  @@redis_client = nil

  def self.redis_client
    @@redis_client ||= Redis.new(
      host: "127.0.0.1",
      port: "6379",
      db: 12
    )
  end
end
