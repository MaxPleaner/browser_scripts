# Scroll
class Scroll

  delegate_to_driver(self)

  def self.start(direction=:down)
    define_methods_in_js
    method = direction.eql?(:down) ? "scrollDown" : "scrollUp"
    script = <<-JS
      window.scrollInterval = setInterval(function(){
        #{method}()
      }, 1000)
      window.isScrolling = true
    JS
    execute_script script
  end

  def self.stop
    script = <<-JS
      clearInterval(scrollInterval)
      window.isScrolling = false
    JS
    execute_script script
  end

  def self.define_methods_in_js
    script = <<-JS
      window.scrollDown = function () {
        window.scrollTo(0,document.body.scrollHeight);
      };
      window.scrollUp = function () {
        window.scrollTo(0,0);
      };
    JS
    execute_script script
  end

end

