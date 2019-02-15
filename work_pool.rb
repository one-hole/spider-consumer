class WorkPool
  @@instance = nil

  attr_accessor :threads, :queue

  def initialize(size = 2)
    @queue, @threads = ::Queue.new, Array.new
  end

  def self.instance
    @@instance ||= self.new
  end

  private
    def run_loop
      loop { (@queue.pop.call if @queue.size > 1) rescue nil }
    end
end