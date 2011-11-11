require 'yay/parser'
require 'yay/lexer'

class Yay
  class Session
    
    # process commandline arguments as if they were from a yay file
    def process_args args
      raise ArgumentError, "args" unless args.kind_of? Array
      process_string args.join(' ')
    end
    
    # process a string of yay commands
    def load_string string
      parser = Yay::Parser.new
      parser.engine = self
      parser.lexer  = Yay::Lexer.new
      parser.parse string
    end
    
    def add_match strings, colours, is_line
      puts "add_match #{strings.join(',')} = #{colours}, line?=#{is_line}"
    end
    
    def add_assignment strings, variable
      puts "add_assignment #{strings.join(',')} = #{variable}"
    end
    
    def add_equivalence x, y
      puts "add_equivalence #{x} = #{y}"
    end

    def load_file str
      puts "load #{str}"
    end
  end
end