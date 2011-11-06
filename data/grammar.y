# the yay language grammar

class Parser
rule

  main: expressions
      |

  expressions: expression
             | expression and_opt expressions

  expression: phrase
            | command

  phrase: subjects verbs_opt predicate
        | subjects predicate

  verbs_opt: verbs
           |

  verbs: verb
       | verb verbs

  verb: is
      | is a
      | are

  subjects: subject
          | subject and_opt subjects

  subject: regex
         | literal
         | literal_regex

  predicate: variable
           | effect

  command: case_opt sensitive
         | case_opt insensitive
         | include_words filename
         | all the_opt predicate verb_opt predicate

  and_opt: and
         |

  the_opt: the
         |

  case_opt: case
          |
end

---- header
require 'yay/engine'
require 'yay/lexer'

class Yay
---- inner
  
  # the engine tracks symbols, etc
  def engine=(engine)
    raise ArgumentError, "engine" unless engine.kind_of? Yay::Engine
    @engine = engine
  end

  # the lexer is where we get our tokens from
  def lexer=(lexer)
    raise ArgumentError, "lexer" unless lexer.kind_of? Yay::Lexer
    @lexer = lexer
  end

  # parse a string
  def parse(str)
    raise ArgumentError, "string" unless str.kind_of? String
    raise ArgumentError, "lexer" unless @lexer.kind_of? Yay::Lexer
    raise ArgumentError, "engine" unless @engine.kind_of? Yay::Engine
    @lexer.use_string(str)
    do_parse
  end

  # get the next token
  def next_token
    @lexer.next_token
  end

---- footer
end # class Yay
