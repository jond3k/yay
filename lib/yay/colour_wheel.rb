# To change this template, choose Tools | Templates
# and open the template in the editor.

class Yay
  class ColourWheel
    
    # not colours as such. commandline support varies
    MISC = {
      :reset      => 0,
      :bright     => 1,
      :dim        => 2,
      :underscore => 4,
      :blink      => 5,
      :reverse    => 7,
      :hidden     => 8,	
      
      :normal     => 0, #alias
      :invert     => 7, #alias
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

    def self.get_misc colour
      return MISC[colour]
    end
    
    def self.get_fg colour
      return FG[colour]
    end
    
    def self.get_bg colour
      return BG[colour]
    end

    def self.all_names
      # assume BG and FG have the same keys
      MISC.keys | FG.keys
    end

    def get_start(num)
      "\033[#{a}m"
    end

    def get_end()

    end
  end
end