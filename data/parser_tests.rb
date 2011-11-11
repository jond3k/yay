require 'yay/colour_wheel'
class Yay
PARSER_TESTS = {

  # empty files
  ""  => [],
  " " => [],

  # simple match
  "apples are green" => [
    ['apples', [ColourWheel::FG[:green]]],
  ],

  # multiple match without and or are
  "apples grass green" => [
    ['apples', [ColourWheel::FG[:green]]],
    ['grass', [ColourWheel::FG[:green]]],
  ],

  # multiple match with and
  "apples and grass green" => [
    ['apples', [ColourWheel::BG[:green]]],
    ['grass', [ColourWheel::BG[:green]]],
  ],

  # multiple match with and and are
  "apples and grass are green" => [
    ['apples', [ColourWheel::BG[:green]]],
    ['grass', [ColourWheel::BG[:green]]],
  ],

  # more matches
  "apples olives and grass are green" => [
    ['apples', [ColourWheel::BG[:green]]],
    ['olives', [ColourWheel::BG[:green]]],
    ['grass', [ColourWheel::BG[:green]]],
  ],

  # newlines allowed
  "apples \nolives and \ngrass are\n green" => [
    ['apples', [ColourWheel::BG[:green]]],
    ['olives', [ColourWheel::BG[:green]]],
    ['grass', [ColourWheel::BG[:green]]],
  ],
}

end