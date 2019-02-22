class HltvService

  attr_accessor :opts

  def initialize(opts = nil)
    @opts = JSON.parse(opts)
  end

  def call
    puts "call --------"
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
        Battle.update(

        )
      else
        Battle.create_by_opts(@opts)
      end
    end

end

# 1: League find_or_create_by
# 2: Team1 & Team2
# 3: Battle
