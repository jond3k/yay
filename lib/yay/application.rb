require 'yay/parser'
require 'yay/colourizer'
require 'yay/version'

class Yay
  class Application

    # arg that can be used if you don't want the application to do anything
    DO_NOTHING_ARG = '--do-nothing'
    
    # arg that can be used if you want to dump the rules instead of using them
    DUMP_RULES_ARG = '--dump'
    
    # arg that can be used to dump the version and exit
    SHOW_VERSION_ARG = '--version'

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
      
      preArg = @args[0]
      @args.shift if preArg == DO_NOTHING_ARG || 
                     preArg == DUMP_RULES_ARG ||
                     preArg == SHOW_VERSION_ARG
      
      if preArg == SHOW_VERSION_ARG
        puts Yay::version
        exit
      end
      
      return if preArg == DO_NOTHING_ARG
      
      begin      
      
        @parser = Yay::Parser.new
        @parser.parse_array(@args)
        @rules = @parser.get_rules

        @colourizer = Yay::Colourizer.new @rules, @input, @output
        
        if preArg == DUMP_RULES_ARG
          dump_colours @colourizer.line_rules, @colourizer.part_rules
          return
        end

        @colourizer.colourize_pipe
      rescue Yay::Error => error
        @error.puts error.printable_message
      rescue Interrupt
      end
    end
    
    def dump_colours line_rules, word_rules
     
      puts "line rules:" if line_rules
      
      line_rules.each { |rule| 
        puts "#{rule[0]} => #{rule[1].dump}"
      }
      
      puts "word rules:" if word_rules
      
      word_rules.each { |rule|
        puts "#{rule[0]} => #{rule[1].dump}"
      }
    end

  end
end