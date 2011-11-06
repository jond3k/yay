# the yay language grammar

class Yay
  prechigh
    nonassoc UMINUS
    left 'and'
  preclow
rule

  main: expressions
      |

  expressions: expression
             | expression and_opt expressions

  expression: phrase
            | command
            | expression

  phrase: subjects verbs_opt predicate
        | subjects predicate

  verbs_opt: verbs
           |

  verbs: verb verbs
       | verb

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
# $Id$
---- inner
  
  def parse(str)
    @q = []
    until str.empty?
      case str
      when /\A\s+/
      when /\A\d+/
        @q.push [:NUMBER, $&.to_i]
      when /\A.|\n/o
        s = $&
        @q.push [s, s]
      end
      str = $'
    end
    @q.push [false, '$end']
    do_parse
  end

  def next_token
    @q.shift
  end

---- footer

parser = Calcp.new
puts
puts 'type "Q" to quit.'
puts
while true
  puts
  print '? '
  str = gets.chop!
  break if /q/i =~ str
  begin
    puts "= #{parser.parse(str)}"
  rescue ParseError
    puts $!
  end
end
