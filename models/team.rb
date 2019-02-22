class Team < BaseRecord
  has_many :aliases, foreign_key: :team_id, class_name: 'TeamAlias'
end
