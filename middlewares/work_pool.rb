class WorkPool
  @@instance = nil
  
  attr_accessor :threads, :queue

  def initialize(size = 5)
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

  # 这里之后该用 Mutex 和 WaitGroup 的方式
  # Mutex 保证了「代码区间」一次只有一个线程在「执行」
  private
    def run_loop
      loop do
        sleep 0.1
        (@queue.pop.call if @queue.size > 0) rescue nil
      end
    end
end
