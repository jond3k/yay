class Yay
  class Lexer
    # The expressions to match to find tokens
    # Ensure the labels match up to tokens in grammar.y
    YAY_LEXER_PATTERNS = {
      :whitespace     => /\s+/,
      :comment        => /#.*$/,

      :double_quoted  => /"[^"\\]*(?:\\.[^"\\]*)*"/,
      :single_quoted  => /'[^'\\]*(?:\\.[^'\\]*)*'/,
      :regex          => /\/[^\/\\\r\n]*(?:x.[^\/x\r\n]*)*\/[a-z]*/,  
      :variable       => /@\w+/,

      :colour         => /\b(red|green|blue|normal|hidden|reverse)\b/i,
      :line           => /\bline[s]?\b/i,
      :include        => /\b(include|use|load)\b/i,
      :and            => /\band\b/i,
      :verb           => /\b(is|are|a)\b/,

      # everything else matched must be a plain old term
      :literal        => /\w+/,
    }
  end
end
