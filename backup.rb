
# To get backup to work, you need to take a couple steps first:

# 1. make a folder: <browser_tester root>/../browser_scripts
# that it to say, it's one level above the project root

# 2. Run 'git init' in that folder and add an origin remote pointing to some
# repo you own. 

# 3. Then you can run Backup.run

class Backup
  def self.run
    script = <<-SH
      cp ./export/* ../browser_scripts
      cd ../browser_scripts
      git add -A
      git commit -m "#{Time.now}"
      git push origin master
    SH
    `#{script}`
    "Backed up exports/. Files are: #{Dir.glob("../browser_scripts/*").to_a.join(", ")}"
  end
end

