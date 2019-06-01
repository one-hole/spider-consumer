module Matches
  class Round < BaseRecord
    self.table_name = "csgo_rounds"

    belongs_to :csgo, class_name: "Csgo"
  end
end
