require 'strscan'
require 'yay/lexer_regex'

class Yay  
  class Lexer
		attr :context_name
    
    def initialize(string="", context_name=nil)
      @position     = 0
      @line         = 1
			@context_name = context_name
      
      # default to an empty string scanner. this provides us an endless number
      # of eofs
      use_string(string)
    end
   
	def context_name= value
		@context_name = value
	end

    # take a string and begin scanning it
    def use_string(string)
      @scanner = StringScanner.new string
    end
    
    def position
      @position
    end
    
    def line
      @line
    end
    
    # get the next token in the file
    def next_token
      return nil if @scanner.empty?

      unless @scanner.empty?
        get_patterns.each { |token| 
          type  = token[0]
          value = @scanner.scan(token[1])
          next unless value
          return next_token if type == :whitespace
          return next_token if type == :comment
          @position += 1
          return normalize_token type, value
        }
      end
      return [:junk, @scanner.scan_until(/$/)]
    end
    
    # perform transformations on the values
    def normalize_token type, value  
      case type
      when nil
      when :double_quoted
        value = value[1, value.length - 2]
        while value.sub!("\\\"", "\"") != nil
        end
        type = :literal
      end
      return [type, value]
    end
  end
end
