require 'pathname'


module FindT
  class Printer

    COLORS = {
      black:   0,
      red:     1,
      green:   2,
      yellow:  3,
      blue:    4,
      magenta: 5,
      cyan:    6,
      white:   7,
    }

    def initialize(root_path, isatty)
      @root_path = Pathname.new root_path
      @isatty = isatty
    end

    def print_header
      puts 'Starting find_t at %s' % @root_path.to_s
      puts 'Scanning...'
    end

    def print_results(founds)
      unless founds.any?
        print_empty
        return
      end

      founds
      .reverse
      .group_by { |f| f[:locale] }
      .sort_by { |f| f[0] }
      .each do |(locale, locale_founds)|
        print_title locale

        locale_founds.each.with_index do |found, i|
          print_translation found, i.zero?
        end
      end
    end

    private def print_empty
      puts
      puts color("Can't find translation for the key", :red)
    end

    private def print_title(title)
      puts
      puts color('==> %s' % title, :yellow)
      puts
    end

    private def print_translation(found, conflicted)
      text = printable_text found[:text]
      file = relative_path found[:file]

      puts <<-EOS
- #{file}:#{found[:line]}#{conflicted ? '' : ' [CONFLICTED]'}
  #{color(text, :green)}
EOS
    end

    private def printable_text(text)
      (text == '') ? '{ ... }' : text
    end

    private def relative_path(file)
      return file unless @root_path
      Pathname.new(file).relative_path_from(@root_path).to_s
    end

    private def color(str, c)
      @isatty ? "\e[1;%dm%s\e[0m" % [30 + COLORS[c], str] : str
    end

  end
end
