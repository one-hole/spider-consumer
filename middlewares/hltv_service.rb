=begin
  Author: 曾涛
  Desc:   HLTV 的入库处理
  Date:   2019-05-23
  Email:  zengtao@risewinter.com
  #TODO:  正在进行中的比赛是没有时间字段的，所以下面有一些逻辑需要修改
=end

class HltvService

  attr_accessor :opts, :redis_client

  def initialize(opts = nil)
    @opts = JSON.parse(opts)
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
      @team1 = Team.find_by(offical_id: @opts["team1"]["id"], game_id: 2)
      @team2 = Team.find_by(offical_id: @opts["team2"]["id"], game_id: 2)

      @team1 = Team.create(game_id: 2, offical_id: @opts["team1"]["id"], name: @opts["team1"]["name"]) unless @team1
      @team2 = Team.create(game_id: 2, offical_id: @opts["team2"]["id"], name: @opts["team2"]["name"]) unless @team2
    end

    def build_battle
      return unless (@league && @team1 && @team2)
      @battle = Battle.find_by(offical_id: @opts["id"])

      # 如果是 Live 状态
      if @battle
        puts @battle.offical_id
        puts @opts["live"]
        return if (@battle.start_time == Time.at(@opts["date"].to_i / 1000) && (@battle.live == @opts["live"]))

        if true == @opts["live"] 
          @battle.update({live: true})
        else 
          @battle.update(
            start_time: Time.at(@opts["date"].to_i / 1000),
            live:       @opts["live"]
          )
        end

      else
        # 目前发现正在进行中的比赛不会有时间、也就是上面逻辑要判断一下
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
