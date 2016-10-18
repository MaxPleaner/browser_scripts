# define Backup
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

