require_relative '../lib/utils'
require_relative '../lib/message'
require 'date'

module Key
  class KeyString
    class << self
      def closed?(toml_file)
        KeyStringHandler.unclosed?(toml_file)
      rescue KeyStringHandler::UnclosedStringError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message)
      end
    end

    class KeyStringHandler
      @rgx_unclosed = Utils::Error.unclosed_string

      class UnclosedStringError < StandardError
        def message
          'Unclosed string.'
        end
      end

      def self.unclosed?(toml_file)
        raise UnclosedStringError unless @rgx_unclosed.match?(toml_file.line)
      end
    end
  end

  class KeyInt
    class << self
      def which_type?(toml_file)
        value = toml_file.value_arr[0]
        sig = value[0] + value[1] + value[2]
        case sig
        when /[xX]/
          Utils::Slice.get_bad_hex(toml_file)
        when /[oO]/
          Utils::Slice.get_bad_oct(toml_file)
        when /[bB]/
          Utils::Slice.get_bad_bin(toml_file)
        else
          Utils::Slice.get_bad_int(toml_file)
        end
      end

      def valid?(toml_file)
        KeyIntHandler.zero_padding(toml_file)
        KeyIntHandler.invalid_int(toml_file)
      rescue KeyIntHandler::ZeroPaddingError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message, toml_file.value_arr[0])
      rescue KeyIntHandler::InvalidIntError => e
        toml_file.new_error

        Utils::Slice.get_var_name(toml_file)
        name = toml_file.value_arr[2]
        bad_char = which_type?(toml_file)
        type = toml_file.value_arr[3]
        msg = "#{e.message} #{type} variable \"#{name[0]}\". Begining at \"#{bad_char}\""
        Message::Error.display_error(toml_file, msg, toml_file.value_arr[0])
      end
    end

    class KeyIntHandler
      def self.zero_padding(toml_file)
        raise ZeroPaddingError if Utils::Error.padded_int(toml_file)
      end

      def self.invalid_int(toml_file)
        e = Utils::Value.invalid_int(toml_file)
        raise InvalidIntError if e.is_a?(ArgumentError)
      end

      class ZeroPaddingError < StandardError
        def message
          'Zero padding integer.'
        end
      end

      class InvalidIntError < ArgumentError
        def message
          'Invalid integer value for'
        end
      end
    end
  end

  class KeyFloat
    class << self
      def valid?(toml_file)
        KeyFloat.invalid_float(toml_file)
      rescue KeyFloat::InvalidFloatError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message, toml_file.value_arr[0])
      end
    end
    def self.invalid_float(toml_file)
      e = Utils::Value.invalid_float(toml_file)
      raise InvalidFloatError if e.is_a?(ArgumentError)
    end

    class InvalidFloatError < ArgumentError
      def message
        'Invalid value for float.'
      end
    end
  end

  class KeyDate
    class << self
      def valid?(toml_file)
        KeyDate.invalid_date(toml_file)
      rescue KeyDate::InvalidDateError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message, toml_file.value_arr[0])
      end
    end

    def self.invalid_date(toml_file)
      e = Utils::Value.invalid_date(toml_file)
      raise InvalidDateError if e.is_a?(Date::Error)
    end

    class InvalidDateError < Date::Error
      def message
        'Invalid date format'
      end
    end
  end
end
