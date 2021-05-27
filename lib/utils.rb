module Utils
  class Slice
    @numeric_type = %w[int float date_time].freeze
    class << self
      def slice_value(toml_file)
        toml_file.line.split(/.+=\s+/) do |c|
          c.split(/\s+#.+\n?/) do |k|
            toml_file.value_arr[0] = k
          end
        end
      end

      def get_value(toml_file)
        slice_value(toml_file)
        type = nil
        if !/[xX:]/.match?(toml_file.value_arr[0]) && /[eE.]/.match?(toml_file.value_arr[0])
          type = @numeric_type[1]
        elsif !toml_file.value_arr[0].include?(':')
          type = @numeric_type[0]
        elsif toml_file.value_arr[0][4] == '-' || toml_file.value_arr[0][2] == ':'
          type = @numeric_type[2]
        end
        type
      end

      def get_comment(toml_file)
        line =  toml_file.line
        k = line.split(/\s*?#/)
        l = 0
        k.length.times do |i|
          l = i if k[i].include?('"')
        end

        unless k[l + 1].nil? 
          toml_file.value_arr[1] = k[l + 1]
        end
      end
    end
  end

  class Element
    @is_comment = Regexp.new(/#/)
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
    @unclosed = Regexp.new('".+"')
    class << self
      def no_white_space
        @no_ws
      end

      def unclosed_string
        @unclosed
      end

      def padded_int(toml_file)
        zero = toml_file.value_arr[0][0] == '0'
        number = /[0-9]/.match?(toml_file.value_arr[0][1])
        zero && number
      end
    end
  end

  class Value
    class << self
      def invalid_int(toml_file)
        Integer(toml_file.value_arr[0])
      rescue ArgumentError => e
        e
      end

      def invalid_float(toml_file)
        Float(toml_file.value_arr[0])
      rescue ArgumentError => e
        e
      end
    end
  end
end
