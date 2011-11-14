require 'yay/colour_wheel'

class Yay
  class Colourizer
    def initialize rules, input, output
      colourize_rules rules
      @input   = input
      @output  = output
    end
    
    def line_rules
      @line_rules
    end
    
    def part_rules
      @part_rules
    end

    def colourize_rules rules
      @line_rules = []
      @part_rules = []

      rules.each { |rule|

        regex   = rule[0]
        colours = rule[1]
        is_line = rule[2]

        colour_string = ColourWheel::begin_colours(colours)

        if is_line
          @line_rules.unshift [regex, colour_string]
        else
          @part_rules.unshift [regex, colour_string]
        end
      }
    end

    def colourize_pipe
      default_end_colour = ColourWheel::end_colour
      
      @input.each_line { |line|

        # track the line_rules end colour so we can return to this after each match
        end_colour = default_end_colour

        #
        @line_rules.each { |rule| 
          if line.match(rule[0])
            line = "#{rule[1]}#{line.rstrip}#{default_end_colour}"
            end_colour = rule[1]
            # only allow one line
            break
          end
        }

        # 
        @part_rules.each { |rule|
          line.gsub!(rule[0], "#{rule[1]}\\0#{end_colour}")
        }

        @output.puts line
      }
    end
  end
end