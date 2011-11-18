class Yay
  # the colour wheel contains all the constants needed to create coloured text
  # there are also a few static helper methods to make rendering text easier
  class ColourWheel
    
    # commands. support varies
    MISC = {
      :reset       => 0,
      :bright      => 1,
      :dim         => 2,
      :underscore  => 4,
      :blink       => 5,
      :reverse     => 7,
      :hidden      => 8,	
      
      :normal      => 0, #alias
      :invert      => 7, #alias
      :inverted    => 7, #alias
      :underscored => 4, #alias
    }
    
    # foreground colours
    FG = {
      :black   => 30,
      :red     => 31,
      :green   => 32,
      :yellow  => 33,
      :blue    => 34,
      :magenta => 35,
      :cyan    => 36,
      :white   => 37,
    };

    # background colours
    BG = {
      :black   => 40,
      :red     => 41,
      :green   => 42,
      :yellow  => 43,
      :blue    => 44,
      :magenta => 45,
      :cyan    => 46,
      :white   => 47
    };

    # return all the possible colour names
    # the keys are used as string representations by the parser
    def self.all_names
      # assume BG and FG have the same keys
      MISC.keys | FG.keys
    end

    # ge the string that begins the current colour code
    def self.begin_colours(colour_numbers)
      "\033[#{colour_numbers.join(';')}m"
    end

    # the command necessary to stop printing with colour
    def self.end_colour()
      "\033[0m"
    end
  end
end