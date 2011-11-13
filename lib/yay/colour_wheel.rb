# To change this template, choose Tools | Templates
# and open the template in the editor.

class Yay
  class ColourWheel
    
    # not colours as such. commandline support varies
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

    def self.all_names
      # assume BG and FG have the same keys
      MISC.keys | FG.keys
    end

    def begin_colour(colours)
      "\033[#{colours.join(';')}m"
    end

    def end_colour()
      "\033[0m"
    end
  end
end