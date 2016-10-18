module AngelList
  delegate_to_driver(self)
  Email = ENV["ANGEL_LIST_EMAIL"]
  Password = ENV["ANGEL_LIST_PASSWORD"]
  unless [Email, Password].all?
    raise(
      ArgumentError,
      "Need to set ANGEL_LIST_EMAIL and ANGEL_LIST_PASSWORD in env"
    )
  end
end

# log into angellist
module AngelList

  def self.login
      
    visit "https://angel.co/login"

    script = <<-JS

      $("#user_email").val("#{Email}")
      $("#user_password").val("#{Password}")
     $("#user_password").parents("form").find("input[type='submit']").trigger("click")

    JS

    execute_script script

  end
end

# visit angellist jobs
module AngelList
  def self.visit_jobs

    visit 'https://angel.co/jobs'

  end
end

# get job listings
module AngelList

  def self.get_job_listings

    script = <<-JS

      setTimeout(function(){

        function extractHeaderInfo($headerInfo, data) {
          $("body").append("1")
          var companyName = $headerInfo.find(".browse-table-row-name").text()
          companyName = companyName.split("\\n").join("")
          var desc = $headerInfo.find(".tagline").text()
          desc = desc + "\\n" + $headerInfo.find(".tag-row").text() 
          var jobs = $headerInfo.find(".collapsed-job-listings").text()
          return data.concat([{
            name: companyName,
            desc: desc,
            jobs: jobs,
            category: 'angellist'
          }])
        }

        data = []

        $.each($(".header-info"), function(idx, elem) {
          data = extractHeaderInfo($(elem), data)
        })

        $("body").html(
          $("<pre></pre>").text(
            JSON.stringify(data, null, 2)
          )
        )
        
      }, 4000)

    JS

    execute_script script

  end
end

