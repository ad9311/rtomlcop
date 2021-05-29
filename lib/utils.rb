require 'date'

module Utils
  # Class for diferent methods needed to parse line
  class Slice
    @numeric_type = %w[int float date_time].freeze
    class << self
      # Save the current line value into toml_file instance

      private

      def slice_value(toml_file)
        k = toml_file.line.split(/[#=]/)
        toml_file.value_arr[0] = k[1].strip unless k[1].nil?
      end

      public

      # Returns the type of value i.e 'float'
      def get_value(toml_file)
        num = toml_file.value_arr[0]
        type = nil
        if !/[xX:]/.match?(num) && /[eE.]/.match?(num)
          type = @numeric_type[1]
        elsif !num.include?(':') && num[4] != '-'
          type = @numeric_type[0]
        elsif num[4] == '-' || /:/.match?(num)
          type = @numeric_type[2]
        end
        type
      end

      # Save the comment content into toml_file instance
      def get_comment(toml_file)
        line = toml_file.line
        prev = nil
        after = []
        flag = false
        line.length.times do |i|
          flag = true if line[i].include?('#')
          prev = line[i] unless flag
          after << line[i] if flag
        end
        toml_file.value_arr[1] = after.join if prev.nil?
        toml_file.value_arr[1] = prev.concat(after.join) unless prev.nil?
        toml_file.value_arr[1].strip!
      end

      # Joins together variable name and value
      def join_var_val(toml_file)
        slice_value(toml_file)
        line = toml_file.line
        value = toml_file.value_arr[0]
        var = line.split(value)
        toml_file.value_arr[2] = var[0] + value unless value.nil?
      end

      # Method that finds incorrect character in a decimal integer
      def get_bad_int(toml_file)
        toml_file.value_arr[3] = 'integer'
        value = toml_file.value_arr[0]
        bad_char = '*'
        if /[+\-]/.match?(value[0])
          (1..value.length).each do |i|
            bad_char = value[i]
            break if /[^0-9_]/.match?(value[i])
          end
        else
          value.length.times do |i|
            bad_char = value[i]
            break if /[^0-9_]/.match?(value[i])
          end
        end
        bad_char
      end

      # Method that finds incorrect character in a hexadecimal integer
      def get_bad_hex(toml_file)
        toml_file.value_arr[3] = 'hexadecimal'
        value = toml_file.value_arr[0]
        value.slice!(0) if /[\-+]/.match?(value[0])
        bad_char = '0'
        if /0/.match?(value[0]) && /[xX0]/.match?(value[1])
          (2..value.length).each do |i|
            bad_char = value[i]
            break if /[^a-fA-F0-9_]/.match?(value[i])
          end
        else
          value.length.times do |i|
            bad_char = value[i]
            break if /[^a-fA-F0-9_]/.match?(value[i])
          end
        end
        bad_char
      end

      # Method that finds incorrect character in a octal integer
      def get_bad_oct(toml_file)
        toml_file.value_arr[3] = 'octal'
        value = toml_file.value_arr[0]
        value.slice!(0) if /[\-+]/.match?(value[0])
        bad_char = '0'
        if /0/.match?(value[0]) && /[oO]/.match?(value[1])
          (2..value.length).each do |i|
            bad_char = value[i]
            break if /[^0-7_]/.match?(value[i])
          end
        else
          value.length.times do |i|
            bad_char = value[i]
            break if /[^0-7_]/.match?(value[i])
          end
        end
        bad_char
      end

      # Method that finds incorrect character in a binary integer
      def get_bad_bin(toml_file)
        toml_file.value_arr[3] = 'binary'
        value = toml_file.value_arr[0]
        value.slice!(0) if /[\-+]/.match?(value[0])
        bad_char = '0'
        if /0/.match?(value[0]) && /[bB]/.match?(value[1])
          (2..value.length).each do |i|
            bad_char = value[i]
            break if /[^0-1]/.match?(value[i])
          end
        else
          value.length.times do |i|
            bad_char = value[i]
            break if /[^0-1]/.match?(value[i])
          end
        end
        bad_char
      end
    end
  end

  class Element
    # This class is used to determin what type of value is the current line
    @is_comment = Regexp.new(/#/)
    @is_string = Regexp.new(/^[a-zA-Z0-9\-_\s].+=*"/)
    @is_numeric = Regexp.new(/^[a-zA-Z0-9\-_]+\s?+=\s?+[0-9][\w\W]+[^"]$/)
    @is_bolean = Regexp.new(/.+=\s*(?i)(true|false)$/)

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

      def detect_bool
        @is_bolean
      end
    end
  end

  class Error
    # This class parses diferent values a returns them so they are raised in Key module
    @no_ws = Regexp.new('\s*#[^\s].+')
    @unclosed = Regexp.new('".+"')
    @wrong_bool = Regexp.new('(true|false)')
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
        value = toml_file.value_arr[0]
        value.length.times do |i|
          raise Date::Error if /[^0-9\-tTzZ:.\s]/.match?(value[i])
        end
        DateTime.parse(toml_file.value_arr[0])
      rescue Date::Error => e
        e
      end

      def invalid_bool(toml_file)
        value = toml_file.value_arr[0]
        raise NameError unless @wrong_bool.match?(value)
      rescue NameError => e
        e
      end
    end
  end
end
