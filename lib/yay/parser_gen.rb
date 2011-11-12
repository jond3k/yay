#
# DO NOT MODIFY!!!!
# This file is automatically generated by racc 1.4.5
# from racc grammer file "scripts/../data/grammar.y".
#

require 'racc/parser'


class Yay

class ParserGen < Racc::Parser

##### racc 1.4.5 generates ###

racc_reduce_table = [
 0, 0, :racc_error,
 1, 11, :_reduce_none,
 0, 11, :_reduce_none,
 3, 12, :_reduce_none,
 1, 12, :_reduce_none,
 1, 13, :_reduce_none,
 1, 13, :_reduce_none,
 1, 13, :_reduce_none,
 1, 13, :_reduce_none,
 1, 13, :_reduce_none,
 4, 15, :_reduce_10,
 3, 16, :_reduce_11,
 4, 17, :_reduce_12,
 3, 18, :_reduce_13,
 2, 19, :_reduce_14,
 3, 20, :_reduce_15,
 1, 20, :_reduce_16,
 1, 24, :_reduce_17,
 1, 24, :_reduce_18,
 2, 22, :_reduce_19,
 1, 22, :_reduce_20,
 1, 14, :_reduce_21,
 0, 14, :_reduce_none,
 1, 23, :_reduce_23,
 0, 23, :_reduce_24,
 2, 21, :_reduce_25,
 0, 21, :_reduce_none ]

racc_reduce_n = 27

racc_shift_n = 36

racc_action_table = [
    -4,    31,    27,     7,     9,    28,    28,    17,     4,     6,
     7,     9,   -22,   -22,    23,    17,     4,     6,     7,     9,
    18,    18,    21,    18,    15,    33,    28,    33 ]

racc_action_check = [
     5,    22,    19,    16,    16,    22,    19,     5,    20,    20,
    20,    20,     3,     3,    15,     3,     0,     0,     0,     0,
    14,    18,     6,     4,     1,    26,    28,    30 ]

racc_action_pointer = [
    14,    24,   nil,     8,    14,     0,    18,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    11,    14,    -1,   nil,    12,     0,
     6,   nil,    -1,   nil,   nil,   nil,    17,   nil,    20,   nil,
    19,   nil,   nil,   nil,   nil,   nil ]

racc_action_default = [
    -2,   -27,    -1,   -16,   -26,   -22,   -27,   -17,    -5,   -18,
    -6,    -7,    -8,    -9,   -26,   -27,   -27,   -21,   -26,   -27,
   -27,   -14,   -27,    36,   -15,   -25,   -24,   -13,   -20,    -3,
   -24,   -11,   -12,   -23,   -19,   -10 ]

racc_goto_table = [
     2,    19,    24,    26,    32,    16,    30,    20,    35,     1,
   nil,    22,    34,   nil,   nil,    25,   nil,   nil,   nil,   nil,
    29 ]

racc_goto_check = [
     2,    11,    10,    12,    13,     4,    12,     4,    13,     1,
   nil,    11,    12,   nil,   nil,    11,   nil,   nil,   nil,   nil,
     2 ]

racc_goto_pointer = [
   nil,     9,     0,   nil,     2,   nil,   nil,   nil,   nil,   nil,
   -14,    -3,   -16,   -22,   nil ]

racc_goto_default = [
   nil,   nil,   nil,     5,   nil,     8,    10,    11,    12,    13,
    14,   nil,   nil,   nil,     3 ]

racc_token_table = {
 false => 0,
 Object.new => 1,
 :variable => 2,
 :include => 3,
 :literal => 4,
 :regex => 5,
 :colour => 6,
 :and => 7,
 :line => 8,
 :verb => 9 }

racc_use_result_var = true

racc_nt_base = 10

Racc_arg = [
 racc_action_table,
 racc_action_check,
 racc_action_default,
 racc_action_pointer,
 racc_goto_table,
 racc_goto_check,
 racc_goto_default,
 racc_goto_pointer,
 racc_nt_base,
 racc_reduce_table,
 racc_token_table,
 racc_shift_n,
 racc_reduce_n,
 racc_use_result_var ]

Racc_token_to_s_table = [
'$end',
'error',
'variable',
'include',
'literal',
'regex',
'colour',
'and',
'line',
'verb',
'$start',
'body',
'command_list',
'command',
'and_opt',
'match',
'assignment',
'substitution',
'equivalence',
'include_file',
'string_list',
'verbs_opt',
'colour_list',
'line_opt',
'string']

Racc_debug_parser = false

##### racc system variables end #####

 # reduce 0 omitted

 # reduce 1 omitted

 # reduce 2 omitted

 # reduce 3 omitted

 # reduce 4 omitted

 # reduce 5 omitted

 # reduce 6 omitted

 # reduce 7 omitted

 # reduce 8 omitted

 # reduce 9 omitted

module_eval <<'.,.,', 'scripts/../data/grammar.y', 17
  def _reduce_10( val, _values, result )
 add_match val[0], handle_colours(val[2]), val[3]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 19
  def _reduce_11( val, _values, result )
 add_assignment val[0], val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 21
  def _reduce_12( val, _values, result )
 add_substitution val[0], handle_colours(val[2]), val[3]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 23
  def _reduce_13( val, _values, result )
 add_equivalence val[0], val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 25
  def _reduce_14( val, _values, result )
 load_file val[0]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 27
  def _reduce_15( val, _values, result )
 val[2].unshift(val[0]); result = val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 28
  def _reduce_16( val, _values, result )
 result = [val[0]]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 30
  def _reduce_17( val, _values, result )
 result = handle_string(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 31
  def _reduce_18( val, _values, result )
 result = handle_regex(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 33
  def _reduce_19( val, _values, result )
 val[1].unshift(val[0].to_sym); result = val[1]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 34
  def _reduce_20( val, _values, result )
 result = [val[0].to_sym]
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 36
  def _reduce_21( val, _values, result )
 result = nil
   result
  end
.,.,

 # reduce 22 omitted

module_eval <<'.,.,', 'scripts/../data/grammar.y', 39
  def _reduce_23( val, _values, result )
 result = true
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 40
  def _reduce_24( val, _values, result )
 result = false
   result
  end
.,.,

module_eval <<'.,.,', 'scripts/../data/grammar.y', 42
  def _reduce_25( val, _values, result )
 result = nil
   result
  end
.,.,

 # reduce 26 omitted

 def _reduce_none( val, _values, result )
  result
 end

end   # class ParserGen

end # class Yay
