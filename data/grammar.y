# the yay language grammar

class ParserGen
rule

  body: command_list                      {  }
      | 

  command_list: command command_list      {  }
              | command                   {  }

  command: string_list verbs_opt value    { string_assign val[0], val[2] }
         | variable verbs_opt value       { var_assign    val[0], val[2] }
         | include literal                { load_file     val[0] }

  string_list: string and_opt string_list { val[2].push(val[0]); result = val[2] }
             | string                     { result = [val[0]] }

  string: literal                         { result = val[0] }
        | regex                           { result = handle_regex(val[0]) }

  value: colour line_opt                  { result =  }
       | colour and_opt colour line_opt   { result = }
       | variable                         { result =  }

  and_opt: and                            {  }
         |                                {  }

  line_opt: line                          {  }
          |                               {  }

  verbs_opt: verb verbs_opt               {  }
           |                              {  }

end

---- header
class Yay
---- inner

---- footer
end # class Yay
