module Matches
  class CsgoInfo < BaseRecord
    self.table_name = "csgo_match_infos"

    belongs_to :infoable, polymorphic: true, optional: true
  end
end
