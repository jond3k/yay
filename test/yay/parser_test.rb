$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'yay/parser'
require 'data/parser_tests'

class ParserTest < Test::Unit::TestCase
  def test_new
    assert Yay::Parser.new.kind_of? Yay::Parser
  end

  # we load parser tests from a data file. ensure the file is structured in the
  # correct way
  def test_parser_valid_data
    
    assert Yay::PARSER_TESTS.kind_of? Hash

    Yay::PARSER_TESTS.each_pair { |input, expected| 
      assert input.kind_of? String
      assert expected.kind_of? Array
    }

  end

  # run the lexer tests we loaded from the data file
  def test_parser_run
    Yay::PARSER_TESTS.each_pair { |input, expected|
      parser = Yay::Parser.new
      assert_equal expected, parser.parse(input), "For |#{input}|"
    }
  end
end
