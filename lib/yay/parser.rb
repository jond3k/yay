require 'yay/parser_gen'
require 'yay/lexer'
require 'yay/colour_wheel'
require 'yay/rule_set'
require 'yay/loader'
require 'yay/installer'
require 'yay/errors'
require 'yay/paths'

class Yay
  class Parser < Yay::ParserGen   
		attr :allow_default
		attr :allow_install
		attr :allow_include
		attr :allow_print

		def initialize context_name=nil
      @lexer = Yay::Lexer.new
			@lexer.context_name = context_name
		end

		def allow_include= value
			@allow_include = value
		end
		
		# load a file from a url
    def include_file filename
			raise NotAllowedError.new "include #{filename}", current_position unless @allow_include
      loader = Yay::Loader.new filename
      loader.load
      @ruleset.merge loader.get_rules
    end

		# install a file from a url
    def install_file url
			raise NotAllowedError.new "install #{url}", current_position unless @allow_install
      installer = Yay::Installer.new url
      installer.install
    end
    
		# print the full list of yay files
    def list_installed
			raise NotAllowedError.new "list installed yay files", current_position unless @allow_print
      # TODO
    end
		
		# allow all parser actions
		def allow_all= value
			@allow_default = @allow_install = @allow_include = @allow_print = value
		end

		# load the default file. used when the commandline is empty
		def use_default_file
			# don't throw an error in this case. it's legitimate for a file to be empty
			return unless @allow_default
      loader = Yay::Loader.default_file_loader
      loader.load
      @ruleset.merge loader.get_rules
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
          raise Yay::TooManyColoursError.new fg, bg, colour, current_position
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
      @lexer.use_string(str)
      @ruleset = Yay::RuleSet.new

      do_parse
      get_rules
    end

    # get the next token
    def next_token
      @lexer.next_token
    end

		def current_position
			return [@lexer.position, @lexer.line, @lexer.context_name]
		end
		
    def on_error error_token_id, error_value, cant_touch_this
      type = token_to_str error_token_id
      raise Yay::UnexpectedTokenError.new type, error_value, current_position
    end
  end
end