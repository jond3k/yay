# To change this template, choose Tools | Templates
# and open the template in the editor.

class Yay
  class Application

    # args that can be used if you don't want to application to do anything
    DO_NOTHING_ARGS = ['--do-nothing']

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
      
      
    end
  end
end