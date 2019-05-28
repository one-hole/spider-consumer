# 相较于之前的模型取代之前模型 Series（单复数不好区分的问题）
# Battle 创建之后需要创建 Matches

class Battle < BaseRecord
  
  enum status: {
    canceled:  -1,
    pending:   0,
    ongoing:   1,
    finished:  2
  }

  belongs_to :left_team,  class_name: 'Team', foreign_key: 'left_team_id'
  belongs_to :right_team, class_name: 'Team', foreign_key: 'right_team_id'
  belongs_to :league, class_name: 'League', foreign_key: 'league_id'

end