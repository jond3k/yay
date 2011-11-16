
class Yay
  class Error < StandardError
    attr :position
    
    def printable_message
      raise "Unimplemented printable error"
    end
    
    def printable_position
      array  = @position
      return "" unless @position
      length = array.length
      return " in file #{array[2]}, line #{array[1]}, word #{array[0]}" if array[2]
      return " on line #{array[1]}, word #{array[0]}" if array[1]
      return " at word #{array[0]}" if array[0]
      raise "junk position given to exception"
    end
  end
  
  class AlreadyAssignedError < Error
    attr :variable
    
    def initialize variable
      @variable = variable
    end
    
    def printable_message
      return "The variable #{variable} has already been assigned a value#{printable_position}"
    end
  end
  
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
  
  class UnresolvedSubstitutionError < Error
    attr :variable
    
    def initialize variable
      @variable = variable
    end
    
    def printable_message
      return "The variable #{variable} is being used but hasn't been set #{printable_position}"
    end
  end
  
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
  
  class UnexpectedTokenError < Error
    attr :type
    attr :value
    
    def initialize type, value, position
      @type     = type
      @value    = value
      @position = position
    end

    def extra_message
      return "Since #{value} has a special meaning, try enclosing it in quotes or a regex when searching for it" if type == "colour"
      return ""
    end

    def printable_message
      return "Unexpected #{type} \"#{value}\"#{printable_position}\n#{extra_message}"
    end
  end
end
