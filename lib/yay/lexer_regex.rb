require 'yay/colour_wheel'

class Yay
  class Lexer
    
    # the expressions to match to find tokens
    # ensure the labels match up to tokens in grammar.y
    BASE_PATTERNS = [
      [:whitespace     , /\s+/],
      [:comment        , /#.*$/],

      # strings
      [:double_quoted  , /"[^"\\]*(?:\\.[^"\\]*)*"/],
      [:single_quoted  , /'[^'\\]*(?:\\.[^'\\]*)*'/],
      [:regex          , /\/[^\/\\\r\n]*(?:\\.[^\/\\\r\n]*)*\/(?:[a-z]*\b)?/],
      [:variable       , /@\w+/],

      # keywords
      [:line           , /\bline[s]?\b/i],
      [:install        , /\binstall\b/i],
      [:list_installed , /\b(list|installed)\b/i],
      [:include        , /\b(include|use|load)\b/i],
      [:and            , /(\b(and|but)\b)|,/i],
      [:verb           , /\b(is|are|a|an)\b/],

      # everything else matched must be a plain old term
      [:literal        , /\b\S+\b/],
    ]
    
    # get the regular expressions we need. always use this instead of
    # referencing the base patterns directly as we augment that array with
    # the colour names that are available
    def get_patterns
      patterns = BASE_PATTERNS
      # add the colour keywords. generate these from the colour wheel's constants
      colours = Yay::ColourWheel::all_names.join('|')
      patterns.unshift [:colour, Regexp.new("\\b(#{colours})\\b", Regexp::IGNORECASE)]
      return patterns
    end
  end
end
