
class Yay
  class Loader
    def initialize filename
      @filename = filename
    end
    
    # invoking a new parser and process a string of yay commands
    # any variables inside the parser context will not affect our own
    # this is particularly useful when loading files
    def load_string string
      # invoke a new parser and return the rules it finds
      parser = Yay::Parser.new
      return parser.parse string
    end
    
    # 
    def load_file full_path
      file = File.open(full_path, "rb")
      contents = file.read
      return load_string(contents)
    end
    
    # stat for the file locally and globally
    def resolve_file filename
      paths = [
        "~/.yay/#{filename}",
        "#{$GEM_HOME}/yay/#{filename}"
      ]
      paths.each { |file_name| 
        begin
          stat = File.stat(file_name)
          return file_name if stat
        rescue Errno::ENOENT 
        end
      }
      return nil
    end

    # load a file
    def load
      raise "loading is not yet implemented! :-("
      resolved = resolve_file @filename
      raise "couldn't find #{@filename}" unless resolved
      @rules = load_file resolved
      return @rules
    end

    def get_rules
      
    end
  end
end
