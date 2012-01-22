$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$:.unshift File.join(File.dirname(__FILE__),'..','..')

require 'test/unit'
require 'yay/autoformatter'

# ensures the autoformatter behaves itself =)
class AutoformatterTest < Test::Unit::TestCase
  def test_zero
    sut = Yay::Autoformatter.new
    assert_raise(ArgumentError) { 
      sut.get_rules([])
    }
  end
  
  # test one colour
  def test_one
    sut = Yay::Autoformatter.new
    assert_equal sut.get_rules(['abc']), [["abc", sut.wheel[0], false]]
  end
  
  # test two colours
  def test_two
    sut = Yay::Autoformatter.new
    actual = sut.get_rules(['abc', 'def'])
    expected = [
        ["abc", sut.wheel[0], false],
        ["def", sut.wheel[1], false]
    ]
    assert_equal actual, expected
  end
  
  # ensure we iterate our options. e.g. r,g,b,r,g,b,r
  def test_wrap
    sut = Yay::Autoformatter.new
    items = sut.wheel.length
    
    words = (0..items).map { |i| i.to_s }
    
    expected_start = [words[0],  sut.wheel[0], false]
    expected_end   = [words[-1], sut.wheel[0], false]
    
    actual = sut.get_rules(words)
    assert_equal actual[0],  expected_start
    assert_equal actual[-1], expected_end
  end
  
end
