require 'yay/engine'

class Yay
  class Application

    # args that can be used if you don't want to application to do anything
    DO_NOTHING_ARGS = ['--do-nothing']
    # args that can be used if you only want to load commands
    ONLY_LOAD_ARGS = ['--only-load']

    def initialize(input, output, error, args)
      raise ArgumentError, "input" unless input.kind_of? IO
      raise ArgumentError, "output" unless output.kind_of? IO
      raise ArgumentError, "error" unless error.kind_of? IO
      raise ArgumentError, "args" unless args.kind_of? Array

      @input   = input
      @output  = output
      @error   = error
      @args    = args
      @running = false
    end

    def run
      raise "already running" if @running
      @running = true
      
      return if @args == DO_NOTHING_ARGS
      
      @engine = Yay::Engine.new
      @engine.process_args(@args)

      return if @args == ONLY_LOAD_ARGS
      
      @engine.handle_stream(@input, @output)
    end
  end
end