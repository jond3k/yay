require 'yay/parser'
require 'yay/colourizer'

class Yay
  class Application

    # args that can be used if you don't want the application to do anything
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
      
      return if @args == DO_NOTHING_ARGS
      
      @parser = Yay::Parser.new
      @parser.parse_array(@args)
      @rules = @parser.get_rules
      
      begin
        @colourizer = Yay::Colourizer.new @rules, @input, @output
        @colourizer.colourize_pipe
      rescue Interrupt
      end
    end

  end
end