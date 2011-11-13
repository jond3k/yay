
class Yay
  # manages colour rules
  class RuleSet
    
    def initialize
      # the eventual ruleset
      @rules          = []

      # variable = colour
      @var_to_colours = {}
      
      # variable = variable
      @var_to_var     = {}
      
      # string = variable
      @string_to_var   = []
    end
    
    # merge with another ruleset
    def merge ruleset
      @rules = @rules | ruleset.get_rules
    end
    
    def get_rules
      # ensure we substitute all variables
      substitute_variables if @string_to_var
      @rules
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
      raise "Variable #{variable} has already been assigned"
    end

    # add a VARIABLE = COLOUR match rule so we can substitute variables later
    def add_substitution variable, colours, is_line
      already_substituted_warning variable if @var_to_colours[variable] || @var_to_var[variable]
      @var_to_colours[variable] = [colours, is_line]
    end

    # add a STRING = VARIABLE match rule. the variable will be substuted later
    def add_assignment strings, variable
      strings.each { |string|
        @string_to_var.push [string, variable]
      }
    end
    
    # add a VARIABLE = VARIABLE equivalence rule. x will be substituted later
    def add_equivalence x, y
      @var_to_var[x] = y
    end
    
    # try to find the value of a variable by making substitutions
    def substitute_variable variable

      path    = []
      result  = nil
      current = variable

      while true 
        # detect circular references
        circular_reference_error(path) unless path.index(current).nil?
        path.unshift current
        
        # see if this variable has a value
        result  = @var_to_colours[current]
        break if result
        
        # see if this variable is a reference to another variable
        current = @var_to_var[current]
        break if current.nil?
      end
      
      unresolved_substitution_error variable unless result
      result
    end
    
    def substitute_variables
      @string_to_var.each { |ref| 
        string   = ref[0]
        variable = ref[1]
        result   = substitute_variable(variable)
        add_match([string], result[0], result[1])
      }
      @string_to_var = []
    end
  end
end