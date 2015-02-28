module FindT
  class FileScanner

    YAML_HASH_PATTERN = /\A([ ]*)(["']|)(\w+)\2:\s*(.*)\s*\z/

    def initialize(file)
      @file = file
    end

    def find(scopes)
      @scopes = scopes
      @size   = @scopes.size - 1

      @current_level  = 0
      @current_locale = nil
      @founds         = []

      File.open(@file) do |f|
        f.each_line.with_index do |line, n|
          scan_line line, n
        end
      end

      @founds
    end

    def scan_line(line, n)
      return unless line =~ YAML_HASH_PATTERN

      indent, scope, text = $1, $3, $4
      level = indent.size >> 1

      if level == 0 && text == ''
        self.locale = scope
        return
      end

      if level == @current_level
        if scope == current_scope
          if level == @size
            @founds << {
              locale: @current_locale,
              file:   @file,
              line:   n + 1,
              text:   text,
            }
          elsif '' == text
            @current_level = level + 1
          end
        end
      elsif level < @current_level
        @current_level = level
      end
    end

    private def current_scope
      @scopes[@current_level]
    end

    private def locale=(locale)
      @current_locale = locale
      @current_level  = 1
    end

  end
end
