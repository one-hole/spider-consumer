# User Story
# 这里需要从 Redis 轮询数据、同时推入 WorkPool
class Hltv
  attr_accessor :thread, :redis_client

  def initialize
    @redis_client = Middlewares.redis_client
    @thread = Thread.new(&method(:run_subscribe))
  end

  private
    # 因为数据需要实时、所以还是走 Pub/Sub 比较合适
    def run_subscribe
      @redis_client.subscribe("hltv-matches-channel") do |on|
        on.message do |channel, message|          
          WorkPool.add(HltvService.new(message))
        end
      end
    end

    def run_live_subscribe
      @redis_client.subscribe("aiesports-csgo-websocket") do |on|
        on.message do |channel, message|
          WorkPool.add(HltvLiveService.new(message))
        end
      end
    end
end
