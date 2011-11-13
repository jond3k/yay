require 'yay/colour_wheel'

class Yay
  class Lexer
    
    # The expressions to match to find tokens
    # Ensure the labels match up to tokens in grammar.y
    BASE_PATTERNS = [
      [:whitespace     , /\s+/],
      [:comment        , /#.*$/],

      [:double_quoted  , /"[^"\\]*(?:\\.[^"\\]*)*"/],
      [:single_quoted  , /'[^'\\]*(?:\\.[^'\\]*)*'/],
      [:regex          , /\/[^\/\\\r\n]*(?:x.[^\/x\r\n]*)*\/[a-z]*/],  
      [:variable       , /@\w+/],

      [:line           , /\bline[s]?\b/i],
      [:include        , /\b(include|use|load)\b/i],
      [:and            , /(\b(and|but)\b)|,/i],
      [:verb           , /\b(is|are|a)\b/],

      # everything else matched must be a plain old term
      [:literal        , /\w+/],
    ]
    
    def get_patterns
      patterns = BASE_PATTERNS
      # substitute the colour placeholder for one with real colours 
      colours = Yay::ColourWheel::all_names.join('|')
      patterns.unshift [:colour, Regexp.new("\\b(#{colours})\\b", Regexp::IGNORECASE)]
      return patterns
    end
  end
end
