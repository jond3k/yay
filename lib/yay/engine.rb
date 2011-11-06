require 'yay/parser'
require 'yay/lexer'

class Yay
  class Engine
    
    # process commandline arguments as if they were from a yay file
    def process_args args
      raise ArgumentError, "args" unless args.kind_of? Array
      process_string args.join(' ')
    end
    
    # process a string of yay commands
    def process_string string
      parser = Yay::Parser.new
      parser.engine = self
      parser.lexer  = Yay::Lexer.new
      parser.parse string
    end
    
    def handle_stream input, output
      
    end
  end
end