class WorkPool
  @@instance = nil

  attr_accessor :threads, :queue

  def initialize(size = 2)
    @queue, @threads = ::Queue.new, Array.new
    size.times do
      @threads << Thread.new(&method(:run_loop))
    end
  end

  def self.instance
    @@instance ||= self.new
  end

  def self.add(task = nil)
    instance.queue << task
  end

  private
    def run_loop
      loop do
        (@queue.pop.call if @queue.size > 0) rescue nil
        sleep 1
      end
    end
end
