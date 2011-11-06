$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'yay/application'

class ApplicationTest < Test::Unit::TestCase
  
  def setup
    @doNothing = Yay::Application::DO_NOTHING_ARGS
  end

  # ensure we can instantiate the app
  def test_new
    assert(@doNothing.kind_of? Array)
    assert(
      Yay::Application.new(
        STDIN, STDOUT, STDERR, @doNothing).kind_of? Yay::Application
    )
  end

  # ensure exceptions are thrown when invalid objects are passed in to the ctor
  def test_run_args
    assert_raise(ArgumentError) { 
      Yay::Application.new(nil, STDOUT, STDERR, @doNothing)
    }
    assert_raise(ArgumentError) { 
      Yay::Application.new(STDIN, nil, STDERR, @doNothing)
    }
    assert_raise(ArgumentError) { 
      Yay::Application.new(STDIN, STDOUT, nil, @doNothing)
    }
    assert_raise(ArgumentError) { 
      Yay::Application.new(STDIN, STDOUT, STDERR, nil)
    }
  end

  # ensure an exception is thrown if the application object is reused
  def test_run_once
    app = Yay::Application.new(STDIN, STDOUT, STDERR, @doNothing)
    app.run
    assert_raise(RuntimeError) { 
      app.run
    }
  end
end
