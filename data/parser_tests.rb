require 'yay/colour_wheel'
class Yay
PARSER_TESTS = {

  # empty files
  ""  => [],
  " " => [],

  # simple match
  "apples are green" => [
    ['apples', [ColourWheel::FG[:green]], false],
  ],
  
  # simple match, lines
  "apples are green lines" => [
    ['apples', [ColourWheel::FG[:green]], true],
  ],

  # multiple match without and or are
  "apples grass green" => [
    ['apples', [ColourWheel::FG[:green]], false],
    ['grass',  [ColourWheel::FG[:green]], false],
  ],

  # multiple match with and
  "apples and grass green" => [
    ['apples', [ColourWheel::FG[:green]], false],
    ['grass',  [ColourWheel::FG[:green]], false],
  ],

  # multiple match with and and are
  "apples and grass are green" => [
    ['apples', [ColourWheel::FG[:green]], false],
    ['grass',  [ColourWheel::FG[:green]], false],
  ],

  # more matches
  "apples olives and grass are green" => [
    ['apples', [ColourWheel::FG[:green]], false],
    ['olives', [ColourWheel::FG[:green]], false],
    ['grass',  [ColourWheel::FG[:green]], false],
  ],

  # newlines allowed
  "apples \nolives and \ngrass are\n green" => [
    ['apples', [ColourWheel::FG[:green]], false],
    ['olives', [ColourWheel::FG[:green]], false],
    ['grass',  [ColourWheel::FG[:green]], false],
  ],
  
  # multiple matches
  "apples and olives are green bananas are yellow" => [
    ['apples',  [ColourWheel::FG[:green]],  false],
    ['olives',  [ColourWheel::FG[:green]],  false],
    ['bananas', [ColourWheel::FG[:yellow]], false],
  ],

  # multiple matches without any conjugation
  "apples olives green bananas yellow" => [
    ['apples',  [ColourWheel::FG[:green]],  false],
    ['olives',  [ColourWheel::FG[:green]],  false],
    ['bananas', [ColourWheel::FG[:yellow]], false],
  ],

  # multiple matches with conjugation
  "apples and olives are green but bananas are yellow" => [
    ['apples',  [ColourWheel::FG[:green]],  false],
    ['olives',  [ColourWheel::FG[:green]],  false],
    ['bananas', [ColourWheel::FG[:yellow]], false],
  ],

  # multiple matches with multiple matches and conjugation
  "apples and olives are green but bananas and cheese are yellow" => [
    ['apples',  [ColourWheel::FG[:green]],  false],
    ['olives',  [ColourWheel::FG[:green]],  false],
    ['bananas', [ColourWheel::FG[:yellow]], false],
    ['cheese',  [ColourWheel::FG[:yellow]], false],
  ],
  
  # multiple matches with multiple matches without any conjugation
  "apples olives green bananas cheese yellow" => [
    ['apples',  [ColourWheel::FG[:green]],  false],
    ['olives',  [ColourWheel::FG[:green]],  false],
    ['bananas', [ColourWheel::FG[:yellow]], false],
    ['cheese',  [ColourWheel::FG[:yellow]], false],
  ],
  
  # multiple matches with multiple matches across lines
  "apples and olives are green\n bananas and cheese are yellow" => [
    ['apples',  [ColourWheel::FG[:green]],  false],
    ['olives',  [ColourWheel::FG[:green]],  false],
    ['bananas', [ColourWheel::FG[:yellow]], false],
    ['cheese',  [ColourWheel::FG[:yellow]], false],
  ],
  
  # foreground and background colours
  "apples are red green" => [
    ['apples',  [ColourWheel::FG[:red], ColourWheel::BG[:green]], false],
  ],
  
  # foreground and background colours with lines
  "apples are red green lines" => [
    ['apples',  [ColourWheel::FG[:red], ColourWheel::BG[:green]], true],
  ],
  
  # colour precedence - command first, one colour
  "apples are normal red lines" => [
    ['apples',  [ColourWheel::MISC[:normal], ColourWheel::FG[:red]], true],
  ],
  
  # colour precedence - command first
  "apples are normal red green lines" => [
    ['apples',  [ColourWheel::MISC[:normal], ColourWheel::FG[:red], ColourWheel::BG[:green]], true],
  ],
  
  # two commands
  "apples are normal inverted lines" => [
    ['apples',  [ColourWheel::MISC[:normal], ColourWheel::MISC[:invert]], true],
  ],

  # two commands
  "apples are @nice and @nice are green" => [
    ['apples',  [ColourWheel::FG[:green]], true],
  ],    
}

end