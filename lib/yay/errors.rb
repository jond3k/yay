
class Yay
  # the base class for errors in yay. this provides error reporting in a
  # friendly way (who likes stack traces?)
  class Error < StandardError
    attr :position
    
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
  
  # this error is raised when a variable has already been assigned a value
  # for example @x is red and @x is blue
  class AlreadyAssignedError < Error
    attr :variable
    
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
    attr :action
    attr :path
    
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
    attr :current
    attr :path
    
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
    attr :variable
    
    def initialize variable
      @variable = variable
    end
    
    def printable_message
      return "The variable #{variable} is being used but hasn't been set #{printable_position}"
    end
  end
  
  # raised when include file resolution has failed
  class CouldntFindFileError < Error
    attr :filename
    attr :tried
    
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
    attr :fg
    attr :bg
    attr :colour
    
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
    attr :type
    attr :value
    
    def initialize type, value, position
      @type     = type
      @value    = value
      @position = position
    end

    # add extra feedback for some tokens. help the user out!
    def extra_message
      return "Since #{value} has a special meaning, try enclosing it in quotes or a regex when searching for it" if type == "colour"
      return ""
    end

    def printable_message
      return "Unexpected #{type} \"#{value}\"#{printable_position}\n#{extra_message}"
    end
  end
end
