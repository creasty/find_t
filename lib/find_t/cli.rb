require 'optparse'
require_relative 'scanner'
require_relative 'printer'


module FindT
  class CLI

    def initialize(args, root_path, isatty)
      @root_path = root_path

      parse_options! args

      @scanner = Scanner.new(
        root_path: @root_path,
        rails:     @options['rails'],
      )
      @printer = Printer.new @root_path, isatty

      run
    end

    private def parse_options!(args)
      @options = args.getopts 'rails'
      @name    = args[0]
    end

    private def run
      @printer.print_header @name
      founds = @scanner.scan @name
      @printer.print_results founds
    end

  end
end
