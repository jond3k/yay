$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$:.unshift File.join(File.dirname(__FILE__),'..','..')

require 'test/unit'
require 'yay/lexer'
require 'data/lexer_tests'

class LexerTest < Test::Unit::TestCase
  
  # ensure we can instantiate the app
  def test_new
    assert(Yay::Lexer.new.kind_of? Yay::Lexer)
  end
  
  # ensure the lexer always returns eof if it's not been given data
  def test_without_file
    lexer = Yay::Lexer.new
    assert_equal nil, lexer.next_token
    assert_equal nil, lexer.next_token
  end

  def test_normalize_token_doublequotes
    lexer = Yay::Lexer.new " \"a\\\"bc\" "
    assert_equal [:literal, "a\"bc"], lexer.next_token
    assert_equal nil, lexer.next_token
  end
  
  def test_unmatched_error
    lexer = Yay::Lexer.new "\"a b c\\\""
    assert_equal [:junk, "\"a b c\\\""], lexer.next_token
    assert_equal nil, lexer.next_token
  end

  # we load lexer tests from a data file. ensure the file is structured in the
  # correct way
  def test_lexer_valid_data
    
    assert Yay::LEXER_TESTS.kind_of? Hash

    Yay::LEXER_TESTS.each_pair { |input, expected| 
      assert input.kind_of? String
      assert expected.kind_of? Array
    }

  end

  # run the lexer tests we loaded from the data file
  def test_lexer_run
    Yay::LEXER_TESTS.each_pair { |input, all_expected|

      lexer = Yay::Lexer.new
      lexer.use_string input

      # iterate each expected token
      all_expected.each { |expected| 
        assert_equal expected, lexer.next_token, "For |#{input}|"
      }

      # check for eof at the end
      assert_equal nil, lexer.next_token
    }
  end
  
end
