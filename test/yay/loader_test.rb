$:.unshift File.join(File.dirname(__FILE__),'..', '..','lib')

require 'test/unit'
require 'yay/loader'

class LoaderTest < Test::Unit::TestCase

  # ensure we can instantiate the app
  def test_new
    assert(
      Yay::Loader.new("placeholder")
    )
  end

end
