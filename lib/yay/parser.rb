require 'yay/parser_gen'
require 'yay/lexer'
require 'yay/colour_wheel'
require 'yay/rule_set'
require 'yay/loader'
require 'yay/installer'

class Yay
  class Parser < Yay::ParserGen   

    def lexer= lexer
      @lexer = lexer
    end

    def load_file filename
      loader = Yay::Loader.new filename
      loader.load
      @ruleset.merge loader.get_rules
    end

    # attempt to 
    def install_file url, globally
      installer = Yay::Installer.new url, globally
      installer.install
    end
    
    def handle_string string
      Regexp.new(string, Regexp::IGNORECASE)
    end

    def handle_regex string
      string
    end

    # given an array of colour strings, create an array with the VT100 colour
    # sequences inside
    def handle_colours colours
      fg = bg = nil
      result = []
      # iterate the colour list and try to find up to two colours (foreground,
      # background) and unlimited miscellaneous colours (reset, invert, etc)
      colours.each { |colour| 
        misc_val = ColourWheel::MISC[colour]
        if !misc_val.nil?
          result.push misc_val
        elsif !fg
          fg = ColourWheel::FG[colour]
          result.push fg
        elsif !bg
          bg = ColourWheel::BG[colour]
          result.push bg
        else
          raise "Too many colours: #{colour} (fg: #{fg}, bg: #{bg})"
        end
      }
      result
    end

    def get_rules
      @ruleset.get_rules
    end

    # process commandline arguments as if they were from a yay file
    def parse_array args
      raise ArgumentError, "args" unless args.kind_of? Array
      parse args.join(' ')
    end
    
    # parse a string
    def parse(str)
      @lexer = Yay::Lexer.new unless @lexer
      @lexer.use_string(str)
      @ruleset = Yay::RuleSet.new

      do_parse
      get_rules
    end

    # get the next token
    def next_token
      @lexer.next_token
    end

  end
end