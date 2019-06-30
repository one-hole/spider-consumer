=begin
  Author: 曾涛
  Desc:   HLTV 的 Live 数据处理
  Date:   2019-05-23
  Email:  zengtao@risewinter.com
=end

=begin
  Match
  - Map
  - Match 的比分需要更新
  Round
  - Round 需要更新胜负、原因
  PlayerMatch
  
  #TODO 其实这个数据如果是放在 Redis 里面 Diff 之后增量式传递、能节省不少IO资源
=end

class HltvLiveService

  attr_accessor :obj

  def initialize(obj = nil)
    @obj = obj
  end

  def call
  end
end