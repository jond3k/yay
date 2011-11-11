require 'yay/parser_gen'
require 'yay/session'
require 'yay/lexer'
require 'yay/colour_wheel'

class Yay
  class Parser < Yay::ParserGen   

    def session= session
      @session = session
    end

    def lexer= lexer
      @lexer = lexer
    end

    def handle_regex string
      return string
    end

    def handle_colours colours
      fg = bg = nil
      result = []
      colours.each { |colour| 
        misc_val = ColourWheel::get_misc(colour)
        if !misc_val.nil?
          result.push misc_val
        elsif !fg
          fg = ColourWheel::get_fg(colour)
        elsif !bg
          bg = ColourWheel::get_bg(colour)
        else
          raise "Too many colours: #{colour} (fg: #{fg}, bg: #{bg})"
        end
      }
      result.push fg if fg
      result.push bg if bg
      result
    end
    
    # parse a string
    def parse(str)
      @session = Yay::Session.new unless @session
      @lexer = Yay::Lexer.new unless @lexer
      @lexer.use_string(str)
      do_parse
    end

    # get the next token
    def next_token
      @lexer.next_token
    end

  end
end