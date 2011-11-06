require 'strscan'

class Yay
  class Lexer    
    
    PATTERNS = {
      :newline        => /$/,
      :whitespace     => /\s+/,

      :quoted_edge    => /"/,
      :quoted_content => /[^"\\]/,
      :quoted_escape  => /\\"/,
      
      :literal        => /\w*/,
      
      :regex_edge     => /\//,
      :regex_content  => /[^\/\\]/,
      :regex_escape   => /\\\//,
    }
    
    def use_file_contents(file_contents)
      @scanner = StringScanner.new file_contents
      @line = 0
      @word = 0
    end
    
    # called when we failed to find a token
    def expected_token_error(name, found)
      raise "Expected #{name} found #{found}"
    end

    def match(name)
      pattern = PATTERNS[name]
      raise "unknown pattern #{name}" unless pattern
      @scanner.scan pattern
    end
    
    def token(label, value=nil)
      return [label, value, @line, @word]
    end
    
    def skip_whitespace
      while match(:whitespace)
      end
    end
    
    # match something that is surrounded by 'edges'; quotes, slashes, etc
    def match_edged(edge, content, escape, substitute)
      return nil unless match edge

      # the literal potentially needs multiple matches because of escaped quotes
      value = ""

      begin
        
        # lets find the string literal's body
        part = match(content)
        value += part if part       
        found_content = part
        
        # we might alternatively
        part = match(escape)
        value += substitute if part
        found_escaped = part
        
      end while found_content || found_escaped

      expected_token_error edge, value unless match edge
      return value
    end
    
    # match a quoted literal
    def match_quoted_literal
      return match_edged :quoted_edge, :quoted_content, :quoted_escape, "\""
    end
    
    # match a regex
    def match_regex
      return match_edged :regex_edge, :regex_content, :regex_escape, "\/"
    end
    
    # get the next token in the file
    def next_token
      # return eof if we haven't loaded a file
      return token :eof unless @scanner
      
      skip_whitespace
      
      until @scanner.empty?
        case
        when value = match_regex
          return token :regex, value
        when value = match_quoted_literal
          return token :literal, value
        when value = match(:literal)
          return token :literal, value
        end
      end
      
      return token :eof if @scanner.empty?
    end
  end
end