require 'rubygems'
require 'yay/version'

class Yay

	# some utility functions for finding the current install and .yay paths
	class Paths

		DEFAULT_YAYFILE = 'default'

		# get the paths to installed gems
		def gempaths
			return Gem.path
		end

		# try to determine where yayfiles might be installed based on a gem path
		def gempath_to_yaypath gem_path
			return "#{gem_path}/gems/yay-#{Yay::VERSION}/data/yay"
		end

		# get all the paths where we might be able to find .yay files
		def yay_paths
			result = [current_path,local_yay_path,global_yay_path]
			gempaths.each { |v| 
				result.push gempath_to_yaypath(v)
			}
			return result
		end

    def current_path
      return '.'
    end

		def global_yay_path
			return '/etc/yay'
		end

		# get the path we store local .yay files
		def local_yay_path
			raise "ENV[HOME] not found!" unless ENV['HOME']
			return "#{ENV['HOME']}/.yay"
		end

	end

end
