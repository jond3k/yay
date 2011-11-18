require 'yay/colour_wheel'
class Yay
  # much like the lexer tests, the keys of each entry is the test data and the
  # values are arrays of expected results
PARSER_TESTS = {

  # empty files
  ""  => [],
  " " => [],

  # simple match
  "apples are green" => [
    [/apples/i, [ColourWheel::FG[:green]], false],
  ],
  
  # simple match, lines
  "apples are green lines" => [
    [/apples/i, [ColourWheel::FG[:green]], true],
  ],

  # multiple match without and or are
  "apples grass green" => [
    [/apples/i, [ColourWheel::FG[:green]], false],
    [/grass/i,  [ColourWheel::FG[:green]], false],
  ],

  # multiple match with and
  "apples and grass green" => [
    [/apples/i, [ColourWheel::FG[:green]], false],
    [/grass/i,  [ColourWheel::FG[:green]], false],
  ],

  # multiple match with and and are
  "apples and grass are green" => [
    [/apples/i, [ColourWheel::FG[:green]], false],
    [/grass/i,  [ColourWheel::FG[:green]], false],
  ],

  # more matches
  "apples olives and grass are green" => [
    [/apples/i, [ColourWheel::FG[:green]], false],
    [/olives/i, [ColourWheel::FG[:green]], false],
    [/grass/i,  [ColourWheel::FG[:green]], false],
  ],

  # newlines allowed
  "apples \nolives and \ngrass are\n green" => [
    [/apples/i, [ColourWheel::FG[:green]], false],
    [/olives/i, [ColourWheel::FG[:green]], false],
    [/grass/i,  [ColourWheel::FG[:green]], false],
  ],
  
  # multiple matches
  "apples and olives are green bananas are yellow" => [
    [/apples/i,  [ColourWheel::FG[:green]],  false],
    [/olives/i,  [ColourWheel::FG[:green]],  false],
    [/bananas/i, [ColourWheel::FG[:yellow]], false],
  ],

  # multiple matches without any conjugation
  "apples olives green bananas yellow" => [
    [/apples/i,  [ColourWheel::FG[:green]],  false],
    [/olives/i,  [ColourWheel::FG[:green]],  false],
    [/bananas/i, [ColourWheel::FG[:yellow]], false],
  ],

  # multiple matches with conjugation
  "apples and olives are green but bananas are yellow" => [
    [/apples/i,  [ColourWheel::FG[:green]],  false],
    [/olives/i,  [ColourWheel::FG[:green]],  false],
    [/bananas/i, [ColourWheel::FG[:yellow]], false],
  ],

  # multiple matches with multiple matches and conjugation
  "apples and olives are green but bananas and cheese are yellow" => [
    [/apples/i,  [ColourWheel::FG[:green]],  false],
    [/olives/i,  [ColourWheel::FG[:green]],  false],
    [/bananas/i, [ColourWheel::FG[:yellow]], false],
    [/cheese/i,  [ColourWheel::FG[:yellow]], false],
  ],
  
  # multiple matches with multiple matches without any conjugation
  "apples olives green bananas cheese yellow" => [
    [/apples/i,  [ColourWheel::FG[:green]],  false],
    [/olives/i,  [ColourWheel::FG[:green]],  false],
    [/bananas/i, [ColourWheel::FG[:yellow]], false],
    [/cheese/i,  [ColourWheel::FG[:yellow]], false],
  ],
  
  # multiple matches with multiple matches across lines
  "apples and olives are green\n bananas and cheese are yellow" => [
    [/apples/i,  [ColourWheel::FG[:green]],  false],
    [/olives/i,  [ColourWheel::FG[:green]],  false],
    [/bananas/i, [ColourWheel::FG[:yellow]], false],
    [/cheese/i,  [ColourWheel::FG[:yellow]], false],
  ],
  
  # foreground and background colours
  "apples are red green" => [
    [/apples/i,  [ColourWheel::FG[:red], ColourWheel::BG[:green]], false],
  ],
  
  # foreground and background colours with lines
  "apples are red green lines" => [
    [/apples/i,  [ColourWheel::FG[:red], ColourWheel::BG[:green]], true],
  ],
  
  # colour precedence - command first, one colour
  "apples are normal red lines" => [
    [/apples/i,  [ColourWheel::MISC[:normal], ColourWheel::FG[:red]], true],
  ],
  
  # colour precedence - command first
  "apples are normal red green lines" => [
    [/apples/i,  [ColourWheel::MISC[:normal], ColourWheel::FG[:red], ColourWheel::BG[:green]], true],
  ],
  
  # two commands
  "apples are normal inverted lines" => [
    [/apples/i,  [ColourWheel::MISC[:normal], ColourWheel::MISC[:invert]], true],
  ],

  # a basic substitution
  "apples are @nice and @nice are green lines" => [
    [/apples/i,  [ColourWheel::FG[:green]], true],
  ],
  
  # a more complicated substitution
  "apples and strawberries are @nice and @nice are green red lines" => [
    [/apples/i,       [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
    [/strawberries/i, [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
  ],
  
  # an indirect substitution
  "apples and strawberries are @nice and @nice are @cool and @cool are green red lines" => [
    [/apples/i,       [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
    [/strawberries/i, [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
  ],
  
  # even more indirect
  "apples and strawberries are @nice and @nice are @cool and @cool are @awesome and @awesome are green red lines" => [
    [/apples/i,       [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
    [/strawberries/i, [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
  ],
  
  # complex rules don't interfere with other rules
  "cheese is yellow and apples and strawberries are @nice and @nice are @cool and @cool are @awesome and @awesome are green red lines and jon is @awesome" => [
    [/cheese/i,       [ColourWheel::FG[:yellow]], false],
    [/apples/i,       [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
    [/strawberries/i, [ColourWheel::FG[:green], ColourWheel::BG[:red]], true],
    [/jon/i,          [ColourWheel::FG[:green], ColourWheel::BG[:red]], true]
  ],
}

end