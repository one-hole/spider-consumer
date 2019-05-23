class HltvService

  attr_accessor :opts, :redis_client

  def initialize(opts = nil)
    @opts = JSON.parse(opts)

    puts @opts
    @redis_client = Middlewares.new_client
  end

  def call
    load_league
    load_teams
    build_battle
  end

  private
    # 在这里我们假设 load_league 是永远不会失败的
    def load_league
      @league = League.find_by(offical_id: @opts["event"]["id"])
      @league = League.create_by_opts(opts["event"]) unless @league
    end

    # Team 这里可能需要后台的手动运营
    def load_teams
      @team1 = Team.find_by(offical_id: @opts["team1"]["id"])
      @team2 = Team.find_by(offical_id: @opts["team2"]["id"])
    end

    def build_battle

      return unless (@league && @team1 && @team2)
      @battle = Battle.find_by(offical_id: @opts["id"])

      if @battle
        return if (@battle.start_time == Time.at(@opts["date"].to_i / 1000) && (@battle.live == @opts["live"]))
        @battle.update(
          start_time: Time.at(@opts["date"].to_i / 1000),
          live:       @opts["live"]
        )
      else
        battle = Battle.create(
          left_team:  @team1,
          right_team: @team2,
          league:     @league,
          status:     0,
          game_id:    2,
          start_time: Time.at(@opts["date"].to_i / 1000),
          offical_id: @opts["id"],
          live:       @opts["live"],
          format:     @opts["format"].match(/\d/).to_s.to_i
        )
        # 这里需要发送创建通知
      end
    end

end

# 1: League find_or_create_by
# 2: Team1 & Team2
# 3: Battle
