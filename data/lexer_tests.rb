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

  # quoted literals
  "\"abc\"" => [
    [:literal, "abc"]
  ],

  "\"a b c\"" => [
    [:literal, "a b c"]
  ],
  
 # "\"a b c\\\"" => [
 #   [:literal, "a b c\\"]
 # ],

  " \"abc\\\"def\\\"hij\"" => [
    [:literal, "abc\"def\"hij"]
  ],

  " \"abc\\\"def\\\"hij\" \"123\\\"456\\\"789\"" => [
    [:literal, "abc\"def\"hij"],
    [:literal, "123\"456\"789"]
  ],
=begin
  # regular expressions  
  "/abc/" => [
    [:regex, "/abc/"]
  ],
  
  "/abc def/" => [
    [:regex, "/abc def/"]
  ],
  
  "/abc\/def/" => [
    [:regex, "/abc\/def/"]
  ],
  
  "/abc/i" => [
    [:regex, "/abc/i"]
  ],
  
  "/abc/i 123 /def/ /a\/b/ efg" => [
    [:regex,   "/abc/i"],
    [:literal, "123"],
    [:regex,   "/def/"],
    [:regex,   "/a\/b/"],
    [:literal, "efg"],
  ],
  
  "\"/abc/i\"" => [
    [:literal, "/abc/i"]
  ],
=end
}