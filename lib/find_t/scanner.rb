require 'pathname'
require_relative 'file_scanner'


module FindT
  class Scanner

    def initialize(root_path:, rails: false)
      @root_path, @rails = Pathname.new(root_path), rails
    end

    def files
      return @files if @files

      if @rails
        rails_env_file = File.expand_path @root_path.join('config', 'environment')

        if File.exists? rails_env_file
          require rails_env_file
        else
          raise RailsNotFoundError.new('Cannot find rails environment file')
        end

        @files = I18n.load_path
      else
        @files = Dir.glob @root_path.join('config', 'locales', '**', '*.{yaml,yml}')
      end

      @files
    end

    def scan(key)
      return if !key || '' == key

      scopes = key.split('.').unshift nil
      founds = []

      files.reverse.each do |file|
        founds += FileScanner.new(file).find scopes
      end

      founds
    end

  end
end
