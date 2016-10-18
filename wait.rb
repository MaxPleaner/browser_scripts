# wait 
class Selenium::WebDriver::Wait
  delegate_to_driver(self)
end

module Wait
  delegate_to_driver(self)
  def self.until(time_limit=5, &blk)
    wait = Selenium::WebDriver::Wait.new(
      :timeout => time_limit
    )
    wait.until &blk
  end
  # an error class which can be rescued
  def self.error_class
    Selenium::WebDriver::Error::TimeOutError
  end
end


