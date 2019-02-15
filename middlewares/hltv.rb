require_relative "redis"
require_relative "../work_pool"

# User Story
# 这里需要从 Redis 轮询数据、同时推入 WorkPool

class String
  def call
    puts "call str"
  end
end

class Hltv
  attr_accessor :thread, :redis_client

  def initialize
    @thread = Thread.new(&method(:polling))
    @redis_client = Middlewares.redis_client
  end

  private
    def polling
      loop do
        sleep 2
        WorkPool.instance.queue << "abc"
      end
    end
end
