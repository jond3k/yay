YAY_LEXER_TESTS = {

  # empty files
  ""  => [],
  " " => [],

  # literals
  "abc" => [
    [:literal, "abc"]
  ],

  " abc d_e_f h1i2j " => [
    [:literal, "abc"],
    [:literal, "d_e_f"],
    [:literal, "h1i2j"]
  ],

  # double quotes
  "\"abc\"" => [
    [:literal, "abc"]
  ],

  "\"a b c\"" => [
    [:literal, "a b c"]
  ],

  "123 \"abc\" def" => [
    [:literal, "123"],
    [:literal, "abc"],
    [:literal, "def"]
  ],

  " \"abc\\\"def\\\"hij\"" => [
    [:literal, "abc\"def\"hij"]
  ],

  " \"abc\\\"def\\\"hij\" \"123\\\"456\\\"789\"" => [
    [:literal, "abc\"def\"hij"],
    [:literal, "123\"456\"789"]
  ],

  # regular expressions  
  "/abc/" => [
    [:regex, "/abc/"]
  ],
  
  "/abc" => [
    [:junk, "/abc"]
  ],
  
  "/abc/i" => [
    [:regex, "/abc/i"]
  ],
  
  "/abc def/" => [
    [:regex, "/abc def/"]
  ],
  
  # FIXME
  #"/abc\/def/" => [
  #  [:regex, "/abc\/def/"]
  #],
  
  # FIXME
  #"/abc\/def/i" => [
  #  [:regex, "/abc\/def/i"]
  #],

  "/abc/ 123" => [
    [:regex, "/abc/"],
    [:literal, "123"],
  ],
  
  "/abc/ 123 /def/" => [
    [:regex, "/abc/"],
    [:literal, "123"],
    [:regex, "/def/"],
  ],
  
  "/abc/i 123 /def/" => [
    [:regex, "/abc/i"],
    [:literal, "123"],
    [:regex, "/def/"],
  ],
  
  # FIXME
  #"/abc/i 123 /def/ /abc\/def/ efg" => [
  #  [:regex,   "/abc/i"],
  #  [:literal, "123"],
  #  [:regex,   "/def/"],
  #  [:regex,   "/abc\/def/"],
  #  [:literal, "efg"],
  #], 
  
  # regex as a string
  "\"/abc/i\"" => [
    [:literal, "/abc/i"]
  ],

  "\"/abc/ /def\"" => [
    [:literal, "/abc/ /def"]
  ],
  
}