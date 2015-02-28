require 'pathname'


module FindT
  class Printer

    def initialize(root_path)
      @root_path = Pathname.new root_path
    end

    def print(name, founds)
      unless founds.any?
        print_empty name
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

    private def print_empty(name)
      puts
      puts "Can't find '%s'" % name
    end

    private def print_title(title)
      puts
      puts '== %s' % title
      puts
    end

    private def print_translation(found, conflicted)
      text = printable_text found[:text]
      file = relative_path found[:file]

      puts <<-EOS
- #{file}:#{found[:line]}#{conflicted ? '' : ' [CONFLICTED]'}
  #{text}
EOS
    end

    private def printable_text(text)
      (text == '') ? '{ ... }' : text
    end

    private def relative_path(file)
      return file unless @root_path
      Pathname.new(file).relative_path_from(@root_path).to_s
    end

  end
end
