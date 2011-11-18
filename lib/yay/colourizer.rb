require 'yay/colour_wheel'

class Yay
  # this class adds colour to a stream based on rules that have been generated
  # by a parser
  class Colourizer
    # create a colourizer using specified parser rules and input and output
    # streams (usually stdin/stdout)
    def initialize rules, input, output
      colourize_rules rules
      @input   = input
      @output  = output
    end
    
    # get the rules that are applied to a whole line if it contains matching text
    # of the form [[regex, colour_string],..]
    def line_rules
      @line_rules
    end
    
    # get the rules that are applied to matching text
    # of the form [[regex, colour_string],..]
    def part_rules
      @part_rules
    end

    # process the rules created by a parser and determine the actual strings we
    # need to emit when we use this colour. this breaks parser rules up in to
    # two categories - line rules and part rules
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

    # create a pipe between the input and output streams, applying colour rules
    # to every line that appears. only an interrupt, end of file or exception 
    # will end this process
    def colourize_pipe
      # this is the colour we'll use when we haven't already applied a colour
      # we remember the previous colour as we can colourize words within a line
      # that's already been coloured
      default_end_colour = ColourWheel::end_colour
      
      @input.each_line { |line|

        # track the line_rules end colour so we can return to this after each
        # match
        end_colour = default_end_colour

        # apply all line rules
        @line_rules.each { |rule| 
          if line.match(rule[0])
            line = "#{rule[1]}#{line.rstrip}#{default_end_colour}"
            end_colour = rule[1]
            # leave loop; only allow one line match per line
            break
          end
        }

        # apply all partial rules
        @part_rules.each { |rule|
          line.gsub!(rule[0], "#{rule[1]}\\0#{end_colour}")
        }

        @output.puts line
      }
    end
  end
end