# async
class Async
  ProcessIds = {}
  def self.start(name=nil, interval=nil, &blk)
    name && ProcessIds[name] = true
    Thread.new do
      if name && interval
        while ProcessIds[name]
          sleep interval
          blk.call
        end
      else
        blk.call
      end
    end
  end
  def self.stop(name)
    ProcessIds.delete(name)
  end
end

