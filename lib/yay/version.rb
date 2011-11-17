require 'open3'

class Yay

	VERSION = "0.0.4"

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
