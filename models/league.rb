class League < BaseRecord
  def self.create_by_opts(opts)
    self.create(
      game_id:    2,
      name:       opts["name"],
      offical_id: opts["id"]
    )
  end
end
