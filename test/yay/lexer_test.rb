$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'yay/lexer'
require 'data/lexer_tests'

class LexerTest < Test::Unit::TestCase
  
  # ensure we can instantiate the app
  def test_new
    assert(Yay::Lexer.new.kind_of? Yay::Lexer)
  end

  # a custom assert
  def assert_token(token, type=nil, value=nil, line=nil, word=nil, msg=nil)
    msg = "For test |#{msg}|:"
    
    assert_equal token[0], type,  msg unless type.nil?
    assert_equal token[1], value, msg unless value.nil?
    assert_equal token[2], line,  msg unless line.nil?
    assert_equal token[3], word,  msg unless word.nil?
  end
  
  # ensure the lexer always returns eof if it's not been given data
  def test_without_file
    lexer = Yay::Lexer.new
    assert_token lexer.next_token, :eof
    assert_token lexer.next_token, :eof
  end
  
  # we load lexer tests from a data file. ensure the file is structured in the
  # correct way
  def test_lexer_valid_data
    
    assert YAY_LEXER_TESTS.kind_of? Hash

    YAY_LEXER_TESTS.each_pair { |input, expected| 
      assert input.kind_of? String
      assert expected.kind_of? Array
    }

  end

  # run the lexer tests we loaded from the data file
  def test_lexer_run
    YAY_LEXER_TESTS.each_pair { |input, all_expected|

      lexer = Yay::Lexer.new
      lexer.use_file_contents input

      # iterate each expectd token
      all_expected.each { |expected| 
        assert_token(
          lexer.next_token,
          expected[0],
          expected[1],
          expected[2],
          expected[3],
          input
        )
      }

      # check for eof at the end
      assert_token lexer.next_token, :eof
    }
  end
  
end
