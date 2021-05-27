require 'date'

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
        num = toml_file.value_arr[0]
        type = nil
        if !/[xX:]/.match?(num) && /[eE.]/.match?(num)
          type = @numeric_type[1]
        elsif !num.include?(':') && num[4] != '-'
          type = @numeric_type[0]
        elsif num[4] == '-' || num[2] == ':'
          type = @numeric_type[2]
        end
        type
      end

      def get_comment(toml_file)
        line = toml_file.line
        k = line.split(/\s*?#/)
        l = 0
        k.length.times do |i|
          l = i if k[i].include?('"')
        end

        toml_file.value_arr[1] = k[l + 1] unless k[l + 1].nil?
      end

      def get_var_name(toml_file)
        var = toml_file.line.split(/[\s=]+[\w\W]+/)
        toml_file.value_arr[2] = var
      end

      def get_bad_int(toml_file)
        toml_file.value_arr[3] = 'integer'
        value = toml_file.value_arr[0]
        bad_char = '*'
        if /[+\-]/.match?(value[0])
          (1..value.length).each do |i|
            bad_char = value[i]
            break if /[^0-9]/.match?(value[i])
          end
        else
          value.length.times do |i|
            bad_char = value[i]
            break if /[^0-9]/.match?(value[i])
          end
        end
        bad_char
      end

      def get_bad_hex(toml_file)
        toml_file.value_arr[3] = 'hexadecimal'
        value = toml_file.value_arr[0]
        bad_char = '0'
        if /0/.match?(value[0]) && /[xX]/.match?(value[1])
          (2..value.length).each do |i|
            bad_char = value[i]
            break if /[^a-fA-F0-9]/.match?(value[i])
          end
        else
          value.length.times do |i|
            puts 'here'
            bad_char = value[i]
            break if /[^a-fA-F0-9]/.match?(value[i])
          end
        end
        bad_char
      end

      def get_bad_oct(toml_file)
        toml_file.value_arr[3] = 'octal'
        value = toml_file.value_arr[0]
        bad_char = '0'
        if /0/.match?(value[0]) && /[oO]/.match?(value[1])
          (2..value.length).each do |i|
            bad_char = value[i]
            break if /[^0-7]/.match?(value[i])
          end
        else
          value.length.times do |i|
            puts 'here'
            bad_char = value[i]
            break if /[^0-7]/.match?(value[i])
          end
        end
        bad_char
      end

      def get_bad_bin(toml_file)
        toml_file.value_arr[3] = 'binary'
        value = toml_file.value_arr[0]
        bad_char = '0'
        if /0/.match?(value[0]) && /[bB]/.match?(value[1])
          (2..value.length).each do |i|
            bad_char = value[i]
            break if /[^0-1]/.match?(value[i])
          end
        else
          value.length.times do |i|
            puts 'here'
            bad_char = value[i]
            break if /[^0-1]/.match?(value[i])
          end
        end
        bad_char
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

      def invalid_date(toml_file)
        Date.parse(toml_file.value_arr[0])
      rescue Date::Error => e
        e
      end
    end
  end
end
