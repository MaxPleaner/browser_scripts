# twitter 1 - log in
module Twitter
  
  delegate_to_driver(self)
  Email = ENV["TWITTER_EMAIL"]
  Password = ENV["TWITTER_PASSWORD"]
  unless [Email, Password].all?
    raise(
      ArgumentError,
      "need to set TWITTER_EMAIL and TWITTER_PASSWORD env vars"
    )
  end

  def self.login
    visit 'http://twitter.com'
    sleep 1
    execute_script <<-JS
      $(".js-login").trigger("click")
    JS
    execute_script <<-JS
      $(".js-signin-email").val("#{Email}")
      $(".LoginForm-password > input[type='password']").val("#{Password}")
      $(".js-submit").trigger("click")
    JS
  end
end

# twitter 2 - autotweet

module Twitter
  def self.autotweet(interval=7)
    Async.start('twitter', interval) do
      tweet("(bot says) #{Faker::Hipster.sentence}")
    end
  end
  def self.tweet(text)
    execute_script <<-JS
      $("#global-new-tweet-button").trigger("click")
      $("#tweet-box-global").text("#{text}")
      $("div.TweetBoxToolbar-tweetButton.tweet-button > button").trigger("click")
    JS
    Async.start do
      sleep 1
      MainServer::Websockets.send_to_all(
        log: "tweeted: #{text}"
      )
    end
  end
end

