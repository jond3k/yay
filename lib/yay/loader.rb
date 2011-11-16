require 'yay/paths'

class Yay
  class Loader
    def initialize filename
      @filename = filename
    end
		
		def self.default_file_loader
			return Yay::Loader.new Yay::Paths::DEFAULT_YAYFILE
		end
    
    # invoking a new parser and process a string of yay commands
    # any variables inside the parser context will not affect our own
    # this is particularly useful when loading files
    def parse_string string
      # invoke a new parser and return the rules it finds
      parser = Yay::Parser.new
      return parser.parse string
    end
    	
    # parse a file
    def parse_file full_path
      file = File.open(full_path, "rb")
      contents = file.read
      return parse_string(contents)
    end
    
		# get the potential target paths
    def get_potential_resolutions filename
			paths = Yay::Paths.new
			dirs  = paths.yay_paths
			
			result = []
			dirs.each { |path| 
				result.push("#{path}/#{filename}.yay")
			}

			return result
		end
    
    # try to determine the location of our file
    def resolve_file filename
      paths = get_potential_resolutions filename
      paths.each { |file_name| 
        begin
          stat = File.stat(file_name)
          return file_name if stat.readable?
        rescue Errno::ENOENT 
        end
      }
      return nil
    end

    # load a file
    def load
      resolved = resolve_file @filename
      raise Yay::CouldntFindFileError.new @filename, get_potential_resolutions(@filename) unless resolved
      @rules = parse_file resolved
      return @rules
    end

    def get_rules
      return @rules
    end
  end
end
