module Utils
  class Slice
    @numeric_type = %w[int float date_time].freeze
    class << self
      def get_value(toml_file)
        type = nil
        toml_file.line.split(/.+=\s+/) do |c|
          toml_file.line_value = c
        end

        if !/[xX:]/.match?(toml_file.line_value) && /[eE.]/.match?(toml_file.line_value)
          type = @numeric_type[1]
        elsif !toml_file.line_value.include?(':')
          type = @numeric_type[0]
        elsif toml_file.line_value[4] == '-' || toml_file.line_value[2] == ':'
          type = @numeric_type[2]
        end
        type
      end
    end
  end

  class Element
    @is_comment = Regexp.new(/^(\s+|)#.+./)
    @is_string = Regexp.new(/^[a-zA-Z0-9\-_\s].+=*"/)
    @is_numeric = Regexp.new(/^[a-zA-Z0-9\-_\s].+=[\s+\-.]?+[0-9\-+.]/)

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
    class << self
      def no_white_space
        @no_ws
      end

      def unclosed_string
        @unclosed
      end

      def padded_int(toml_file)
        zero = toml_file.line_value[0] == '0'
        number = /[0-9]/.match?(toml_file.line_value[1])
        zero && number
      end
    end
  end

  class Value
    class << self
      def invalid_int(toml_file)
        Integer(toml_file.line_value)
      rescue ArgumentError => e
        e
      end

      def invalid_float(toml_file)
        Float(toml_file.line_value)
      rescue ArgumentError => e
        e
      end
    end
  end
end
