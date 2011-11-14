class Yay
LEXER_TESTS = {

  # empty files
  ""  => [],
  " " => [],

  # isolated colour
  "red" => [
    [:colour, "red"]
  ],
  
  # non-interference with literals
  "splodge red" => [
    [:literal, "splodge"],
    [:colour, "red"]
  ],
  
  # multiple colours
  "green red" => [
    [:colour, "green"],
    [:colour, "red"]
  ],

  # quoted
  "\"red\" green" => [
    [:literal, "red"],
    [:colour, "green"]
  ],
  
  # word boundaries
  "hatred of greenspan red" => [
    [:literal, "hatred"],
    [:literal, "of"],
    [:literal, "greenspan"],
    [:colour, "red"]
  ],  
  
  # literal
  "abc" => [
    [:literal, "abc"]
  ],

  # multiple literals
  " abc d_e_f h1i2j " => [
    [:literal, "abc"],
    [:literal, "d_e_f"],
    [:literal, "h1i2j"]
  ],

  # double quoted literals
  "\"abc\"" => [
    [:literal, "abc"]
  ],

  "\"a b c\"" => [
    [:literal, "a b c"]
  ],

  # double quoted - non-interference
  "123 \"abc\" def" => [
    [:literal, "123"],
    [:literal, "abc"],
    [:literal, "def"]
  ],

  # double quoted and escaped
  " \"abc\\\"def\\\"hij\"" => [
    [:literal, "abc\"def\"hij"]
  ],

  # multiple double quoted and escaped
  " \"abc\\\"def\\\"hij\" \"123\\\"456\\\"789\"" => [
    [:literal, "abc\"def\"hij"],
    [:literal, "123\"456\"789"]
  ],

  # regular expressions
  "/abc/" => [
    [:regex, "/abc/"]
  ],
  
  # unclosed regex
  "/abc" => [
    [:junk, "/abc"]
  ],
  
  # regex with modifier
  "/abc/i" => [
    [:regex, "/abc/i"]
  ],
  
  # regex with whitespace
  "/abc def/" => [
    [:regex, "/abc def/"]
  ],

  # regex with escaping
  "/abc\\/def/" => [
    [:regex, "/abc\\/def/"]
  ],

  # regex withescaping and modifier
  "/abc\\/def/i" => [
    [:regex, "/abc\\/def/i"]
  ],

  # regex noninterference
  "/abc/ 123" => [
    [:regex, "/abc/"],
    [:literal, "123"],
  ],
  
  # refex noninterference
  "/abc/ 123 /def/" => [
    [:regex, "/abc/"],
    [:literal, "123"],
    [:regex, "/def/"],
  ],
  
  # regex with modifier noninterference
  "/abc/i 123 /def/" => [
    [:regex, "/abc/i"],
    [:literal, "123"],
    [:regex, "/def/"],
  ],

  # regex with modifier, regex with escaping noninterference
  "/abc/i 123 /def/ /abc\\/def/ efg" => [
    [:regex,   "/abc/i"],
    [:literal, "123"],
    [:regex,   "/def/"],
    [:regex,   "/abc\\/def/"],
    [:literal, "efg"],
  ], 
  
  # quoted regex
  "\"/abc/i\"" => [
    [:literal, "/abc/i"]
  ],

  # multiple quoted regexes with whitespace
  "\"/abc/ /def\"" => [
    [:literal, "/abc/ /def"]
  ],
  
  # and
  "and cheese and" => [
    [:and, "and"],
    [:literal, "cheese"],
    [:and, "and"]
  ],    
  
  # quoted and
  "\"and\"" => [
    [:literal, "and"]
  ],
  
  # commas
  "mushroom, chicken and pasta" => [
    [:literal, "mushroom"],
    [:and, ","],
    [:literal, "chicken"],
    [:and, "and"],
    [:literal, "pasta"]
  ],
}
end