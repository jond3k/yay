require 'yay/rule_set'

class Yay
  class Autoformatter
    
    # the colour wheel can be retrieved for unit testing, etc
    attr_reader :wheel
    
    def initialize
      @wheel = [
        [Yay::ColourWheel::FG[:red],   Yay::ColourWheel::MISC[:bold]],
        [Yay::ColourWheel::FG[:green], Yay::ColourWheel::MISC[:bold]],
        [Yay::ColourWheel::FG[:blue],  Yay::ColourWheel::MISC[:bold]],
      ]
      @index = 0
    end
    
    def get_rules strings
      raise ArgumentError, "Cannot be an empty array" unless 
        strings.class == Array and strings.length > 0
      ruleset = Yay::RuleSet.new
      strings.each { |string| 
        colour = @wheel[@index % @wheel.length]
        ruleset.add_match [string], colour, false
        # iterate the index
        @index += 1
      }
      return ruleset.get_rules
    end
  end
end