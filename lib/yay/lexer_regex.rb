require 'yay/colour_wheel'

class Yay
  class Lexer
    
    # The expressions to match to find tokens
    # Ensure the labels match up to tokens in grammar.y
    BASE_PATTERNS = [
      [:whitespace     , /\s+/],
      [:comment        , /#.*$/],

      # strings
      [:double_quoted  , /"[^"\\]*(?:\\.[^"\\]*)*"/],
      [:single_quoted  , /'[^'\\]*(?:\\.[^'\\]*)*'/],
      [:regex          , /\/[^\/\\\r\n]*(?:x.[^\/x\r\n]*)*\/[a-z]*/],  
      [:variable       , /@\w+/],

      # keywords
      [:line           , /\bline[s]?\b/i],
      [:install        , /\binstall\b/i],
      [:installed      , /\binstalled\b/i],
      [:include        , /\b(include|use|load)\b/i],
      [:and            , /(\b(and|but)\b)|,/i],
      [:verb           , /\b(is|are|a|an)\b/],

      # everything else matched must be a plain old term
      [:literal        , /\b\S+\b/],
    ]
    
    def get_patterns
      patterns = BASE_PATTERNS
      # add the colour keywords. generate these from the colour wheel's constants
      colours = Yay::ColourWheel::all_names.join('|')
      patterns.unshift [:colour, Regexp.new("\\b(#{colours})\\b", Regexp::IGNORECASE)]
      return patterns
    end
  end
end
