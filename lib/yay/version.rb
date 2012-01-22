require 'open3'

class Yay

  # the gem version. increment to make a new release!
  VERSION = "0.0.8"

  # yoinked from chef. this gives us the git revision number of the current
  # build if possible. used for --version
  def self.version
    @rev ||= begin
      begin
        rev = Open3.popen3("git rev-parse HEAD") {|stdin, stdout, stderr| stdout.read }.strip
      rescue Errno::ENOENT
        rev = ""
      end
      rev.empty? ? nil : " (#{rev})"
    end
    "#{VERSION}#@rev"
  end

end
