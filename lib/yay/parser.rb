require 'yay/parser_gen'
require 'yay/lexer'
require 'yay/colour_wheel'
require 'yay/rule_set'
require 'yay/loader'
require 'yay/installer'
require 'yay/errors'

class Yay
  class Parser < Yay::ParserGen   
    def load_file filename
      loader = Yay::Loader.new filename
      loader.load
      @ruleset.merge loader.get_rules
    end

    def install_file url
      installer = Yay::Installer.new url
      installer.install
    end
    
    def print_installed
      # TODO
    end
    
    def handle_string string
      string = Regexp::escape(string)
      return Regexp.new(string, Regexp::IGNORECASE)
    end

    def handle_regex string
      return string_to_regex string
    end

    # for lack of a better function, this will take the ending sequence from
    # a regular expression and convert it in to a bytewise options variable
    def extract_regexp_options args
      return 0 if args.nil?
      raise ArgumentError unless args.kind_of? String
      options_map = {
        'i' => Regexp::IGNORECASE,
        'm' => Regexp::MULTILINE,
        'x' => Regexp::EXTENDED,
      }
      options = 0
      args.each { |char|
        options |= options_map[char] || 0
      }
      return options
    end
    
    # for lack of a better function, this will take a string like "/abc/" and
    # transform it in to a regex object
    def string_to_regex string
      matches = /\/([^\/\\\r\n]*(?:\\.[^\/\\\r\n]*)*)\/([a-z]\b)*/.match string
      return nil if matches[1].nil?
      content = Regexp::escape(matches[1])
      options = extract_regexp_options matches[2]
      return Regexp.new(content, options)
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
          raise Yay::TooManyColoursError.new fg, bg, colour, [@lexer.position, @lexer.line]
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

    def on_error error_token_id, error_value, value_stack
      type = token_to_str error_token_id
      raise Yay::UnexpectedTokenError.new type, error_value, [@lexer.position, @lexer.line]
    end
  end
end