$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'yay/parser'

class ParserTest < Test::Unit::TestCase
  def test_new
    assert Yay::Parser.new.kind_of? Yay::Parser
  end
  
  #def test_empty
  #  Yay::Parser.new.parse("")
  #end
  
  #def test_string_colour
  #  Yay::Parser.new.parse("error red")
  #end
  
  #def test_string_verb_colour
  #  Yay::Parser.new.parse("error is red")
  #end
  
  def test_string_verb_colour
    Yay::Parser.new.parse("error /a/ and warn are @serious")
  end
end
