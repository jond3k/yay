# the yay language grammar

class ParserGen
rule

  body: command_list                      {  }
      | literal                           { load_file val[0] }
      | install literal                   { install_file val[1], true }
      | install local literal             { install_file val[2], false }
      |

  command_list: command and_opt command_list      {  }
              | command                           {  }

  command: match
         | assignment
         | substitution
         | equivalence
         | include_file

  match:  string_list verbs_opt colour_list line_opt { @ruleset.add_match val[0], handle_colours(val[2]), val[3] }

  assignment: string_list verbs_opt variable { @ruleset.add_assignment val[0], val[2] }

  substitution: variable verbs_opt colour_list line_opt { @ruleset.add_substitution val[0], handle_colours(val[2]), val[3] }

  equivalence: variable verbs_opt variable   { @ruleset.add_equivalence val[0], val[2]  }

  include_file: include literal           { load_file val[0] }

  string_list: string and_opt string_list { val[2].unshift(val[0]); result = val[2] }
             | string                     { result = [val[0]] }

  string: literal                         { result = handle_string(val[0]) }
        | regex                           { result = handle_regex(val[0]) }

  colour_list: colour colour_list         { val[1].unshift(val[0].to_sym); result = val[1] }
             | colour                     { result = [val[0].to_sym] }

  and_opt: and                            { result = nil }
         |                                { }

  line_opt: line                          { result = true }
          |                               { result = false }

  verbs_opt: verb verbs_opt               { result = nil }
           |                              { }

end

---- header
class Yay
---- inner

---- footer
end # class Yay
