
class Yay
  # the base class for errors in yay. this provides error reporting in a
  # friendly way (who likes stack traces?)
  class Error < StandardError
    attr_reader :position
    
    # override this to provide user feedback
    def printable_message
      raise "Unimplemented printable error"
    end
    
    # a generic representation of the error's location on the line, file, etc
    def printable_position
      array  = @position
      return "" unless @position
      return " in file #{array[2]}, line #{array[1]}, word #{array[0]}" if array[2]
      return " on line #{array[1]}, word #{array[0]}" if array[1]
      return " at word #{array[0]}" if array[0]
      raise "junk position given to exception"
    end
  end
  
  # thrown when an invalid filename was entered
  class BadFilenameError < Error  
    attr_reader :value
    attr_reader :message
    
    def initialize value
      @value   = value
    end
    
    def printable_message
      return "Invalid filename #{value} entered"
    end
  end
  
  # this error wraps an underlying error
  class InstallFailedError < Error
    MAX_LENGTH = 1028
    
    attr_reader :error
    attr_reader :url
    attr_reader :content
    
    def initialize url, error, content=nil
      @url     = url
      @error   = error
      @content = content
      @content = 'empty' if (content==nil||content.strip=="")
      if @content.length >= InstallFailedError::MAX_LENGTH
        @content = "#{@content.slice(0,InstallFailedError::MAX_LENGTH)}\n.."
      end
    end
    
    def printable_message
      return "Failed to download and install file from #{url}\nReason: #{error}\nResponse was:\n#{content}\nCheck your url!"
    end
  end
  
  # this error is raised when a variable has already been assigned a value
  # for example @x is red and @x is blue
  class AlreadyAssignedError < Error
    attr_reader :variable
    
    def initialize variable
      @variable = variable
    end
    
    def printable_message
      return "The variable #{variable} has already been assigned a value#{printable_position}"
    end
  end
  
  # this is a generic access control error that's raised when someoen tries to
  # do something disallowed in their current context. for example, you can
  # use the install command from the command line but not a yayfile
  class NotAllowedError < Error
    attr_reader :action
    attr_reader :path
    
    def initialize action, path
      @action = action
      @path   = path
    end

    def printable_message
      return "You can't #{action} from here"
    end
  end
	
  # raised when there's a circular reference between rules. this happens when
  # variables point back to themselves in some way. e.g. @x is @y and @y is @x
  class CircularReferenceError < Error
    attr_reader :current
    attr_reader :path
    
    def initialize current, path
      @current = current
      @path    = path
    end

    def printable_message
      return "There is a circular reference between variables: #{path.join(' => ')} => #{current}#{printable_position}"
    end
  end
  
  # raised when a variable has been referenced but not given a value. for example
  # cheese is @x without ever defining what @x is
  class UnresolvedSubstitutionError < Error
    attr_reader :variable
    
    def initialize variable
      @variable = variable
    end
    
    def printable_message
      return "The variable #{variable} is being used but hasn't been set #{printable_position}"
    end
  end
  
  # raised when include file resolution has failed
  class CouldntFindFileError < Error
    attr_reader :filename
    attr_reader :tried
    
    def initialize filename, tried
      @filename = filename
      @tried    = tried
    end
    
    def printable_message
      return "Failed to load file \"#{filename}\"#{printable_position}\nPlaced looked:\n #{tried.join("\n ")}"
    end
  end
  
  # raised when a colour sequence was malformed. in practice you can use
  # infinite colour commands but zero to two actual colours, the first one will
  # be the foreground and the second one will be the background
  class TooManyColoursError < Error
    attr_reader :fg
    attr_reader :bg
    attr_reader :colour
    
    def initialize fg, bg, colour, position
      @fg       = fg
      @bg       = bg
      @colour   = colour
      @position = position
    end
    
    def printable_message
      return "There were too many colours in your expression#{printable_position}.\nYou can't use #{colour} as you've already chosen a foreground and background colour"
    end
  end
  
  # raised when an unexpected token was found by the parser. in otherwords,
  # the rules of the syntax have been broken somehow and the user hasn't written
  # a valid command
  class UnexpectedTokenError < Error
    attr_reader :type
    attr_reader :value
    
    def initialize type, value, position
      @type     = type
      @value    = value
      @position = position
    end

    # add extra feedback for some tokens. help the user out!
    def extra_message
      return "Since #{value} has a special meaning, try enclosing it in quotes or a regex when searching for it" if type == "colour"
      return "Have you finished the line off properly?" if type == "$end"
      return ""
    end

    def printable_message
      return "Unexpected text \"#{value}\"#{printable_position}\n#{extra_message}" if type == "error"
      return "Unexpected end of line#{printable_position}\n#{extra_message}" if type == "$end"
      return "Unexpected #{type} \"#{value}\"#{printable_position}\n#{extra_message}"
    end
  end
end
