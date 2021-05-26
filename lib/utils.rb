module Utils
  class Slice
    @numeric_type = %w[int float date_time].freeze
    class << self
      def get_value(toml_file)
        buffer = nil
        type = nil
        toml_file.line.split(/.+=\s*/) do |c|
          buffer = c
        end

        if !/[xX:]/.match?(buffer) && /[eE.]/.match?(buffer)
          type = @numeric_type[1]
        elsif !buffer.include?(':')
          type = @numeric_type[0]
        elsif buffer[4] == '-' || buffer[2] == ':'
          type = @numeric_type[2]
        end
        type
      end
    end
  end

  class Element
    @is_comment = Regexp.new(/^(\s+|)#.+./)
    @is_string = Regexp.new(/^[a-zA-Z0-9\-_\s].+=*"/)
    @is_numeric = Regexp.new(/^[a-zA-Z0-9\-_\s].+=[\s+\-.]+[0-9]/)

    class << self
      def detect_comment
        @is_comment
      end

      def detect_string
        @is_string
      end

      def detect_numeric
        @is_numeric
      end
    end
  end

  class Error
    @no_ws = Regexp.new('\s*#[^\s].+')
    @unclosed = Regexp.new('[a-z0-9]+[\s=]+"+.+"$')
    @padded = Regexp.new('.+=\s+0+[0-9]+')
    class << self
      def no_white_space
        @no_ws
      end

      def unclosed_string
        @unclosed
      end

      def padded_int
        @padded
      end
    end
  end

  class Value
    @invalid_value = Regexp.new(/.+=\s*/)
    @buffer = nil
    class << self
      def invalid_int(toml_file)
        toml_file.line.split(@invalid_value) do |c|
          @buffer = c
        end
        Integer(@buffer)
      rescue ArgumentError => e
        e
      end
    end
  end
end
