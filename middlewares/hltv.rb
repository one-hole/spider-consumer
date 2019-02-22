# User Story
# 这里需要从 Redis 轮询数据、同时推入 WorkPool
class Hltv
  attr_accessor :thread, :redis_client

  def initialize
    @redis_client = Middlewares.redis_client
    @thread = Thread.new(&method(:run_subscribe))
  end

  private
    def run_subscribe
      @redis_client.subscribe("hltv-matches-channel") do |on|
        on.message do |channel, message|
          WorkPool.add(HltvService.new(message))
        end
      end
    end

    def run_loop
      loop do
        sleep 10 # 这里每分钟检查入库一次
        polling
      end
    end

    def polling
      puts "Now polling redis"
      if @redis_client.hlen('hltv-matches') > 0
        values = @redis_client.hvals('hltv-matches')
        values.each { |val| WorkPool.add(HltvService.new(val)) }
        # @redis_client.del('hltv-matches')
      end
    end
end
