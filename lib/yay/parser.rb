require 'yay/parser_gen'
require 'yay/lexer'
require 'yay/colour_wheel'

class Yay
  class Parser < Yay::ParserGen   

    def lexer= lexer
      @lexer = lexer
    end

    # process a string of yay commands
    def load_string string
      parser = Yay::Parser.new
      parser.parse string
    end
    
    # add a simple STRING = COLOUR match rule
    def add_match strings, colours, is_line
      strings.each { |string|
        @rules.push [string, colours, is_line]
      }
    end
    
    def unresolved_substitution_error variable
      raise "No rule for #{variable}"
    end
    
    def circular_reference_error path
      raise "Circular reference: #{path}"
    end
    
    def already_substituted_warning variable
      raise "Variable #{variable} has already been substituted with #{@substitutions[variable]}"
    end

    # add a VARIABLE = COLOUR match rule so we can substitute variables later
    def add_substitution variable, colours, is_line
      already_substituted_warning if @substitutions[variable]
      @substitutions[variable] = [colours, is_line]
    end

    # add a STRING = VARIABLE match rule. the variable will be substuted later
    def add_assignment strings, variable
      @assignments.push [strings, variable]
    end
    
    # add a VARIABLE = VARIABLE equivalence rule. x will be substituted later
    def add_equivalence x, y
      @equivalence.push [x, y]
    end

    def load_file str
      puts "load #{str}"
    end
    
    def handle_string string
      string
    end

    def handle_regex string
      string
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
          result.push fg
        elsif !bg
          bg = ColourWheel::get_bg(colour)
          result.push bg
        else
          raise "Too many colours: #{colour} (fg: #{fg}, bg: #{bg})"
        end
      }
      result
    end

    def get_rules
      @rules
    end
    
    # 
    def resolve_equivalence variable
      path = [variable]
      until current.nil?
        current = @assignment[current]
        circular_reference_error(path) if path.index(current).nil?
        path.shift path
        
        result  = @substitutions[current]
        break if result
      end
      
      unresolved_substitution_error variable unless result
      result
    end
    
    def variable_substitutions
      
    end

    # process commandline arguments as if they were from a yay file
    def parse_array args
      raise ArgumentError, "args" unless args.kind_of? Array
      parse args.join(' ')
    end
    
    # parse a string
    def parse(str)
      @rules         = []
      @equivalence   = []
      @assignments   = []
      @substitutions = {}

      @lexer = Yay::Lexer.new unless @lexer
      @lexer.use_string(str)
      
      do_parse
      variable_substitutions
      get_rules
    end

    # get the next token
    def next_token
      @lexer.next_token
    end

  end
end