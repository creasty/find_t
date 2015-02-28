require 'optparse'
require_relative 'scanner'
require_relative 'printer'


module FindT
  class CLI

    def initialize(args, root_path)
      @root_path = root_path

      parse_options! args

      @scanner = Scanner.new(
        root_path: @root_path,
        rails:     @options['rails'],
      )

      run
    end

    private def parse_options!(args)
      @options = args.getopts 'rails'
      @name    = args[0]
    end

    private def run
      founds = @scanner.scan @name
      printer = Printer.new @root_path
      printer.print @name, founds
    end

  end
end
