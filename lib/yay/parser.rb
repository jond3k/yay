require 'yay/parser_gen'
require 'yay/engine'
require 'yay/lexer'

class Yay
  class Parser < Yay::ParserGen
    def lexer= lexer
      @lexer = lexer
    end

    def handle_regex string
      return string
    end 

    def string_assign strings, value
      puts "Assign:", strings, " Value:", value
    end
    
    # parse a string
    def parse(str)
      @lexer = Yay::Lexer.new unless @lexer
      @lexer.use_string(str)

      @stack = []
      @last  = [0]
      do_parse
    end

    # get the next token
    def next_token
      @lexer.next_token
    end

  end
end