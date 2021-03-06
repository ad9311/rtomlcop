require_relative '../lib/utils'
require_relative '../lib/message'
require 'date'
require 'colorize'

# Dedicated module for variables
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
      private

      def units?(toml_file)
        value = toml_file.value_arr[0]
        index2 = '0'
        index2 = value[2] unless value[2].nil?
        sig = value[0] + value[1] + index2
        sig unless sig.nil?
      end

      public

      def which_type?(toml_file)
        sig = units?(toml_file)
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
        Message::Error.display_error(toml_file, e.message)
      rescue KeyIntHandler::InvalidIntError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message(toml_file))
      end
    end

    class KeyIntHandler
      def self.zero_padding(toml_file)
        raise ZeroPaddingError if Utils::Error.padded_int(toml_file)
      end

      def self.invalid_int(toml_file)
        e = Utils::Error.invalid_int(toml_file)
        raise InvalidIntError if e.is_a?(ArgumentError)
      end

      class ZeroPaddingError < StandardError
        def message
          'Zero padding integer found.'
        end
      end

      class InvalidIntError < ArgumentError
        def message(toml_file)
          char = "\"#{KeyInt.which_type?(toml_file)}\"".red
          type = toml_file.value_arr[3]
          msg = "Invalid #{type} value. #{char} character not permitted."
          msg unless msg.nil?
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
        Message::Error.display_error(toml_file, e.message)
      end
    end

    def self.invalid_float(toml_file)
      e = Utils::Error.invalid_float(toml_file)
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
        Message::Error.display_error(toml_file, e.message)
      end
    end

    def self.invalid_date(toml_file)
      e = Utils::Error.invalid_date(toml_file)
      raise InvalidDateError if e.is_a?(Date::Error)
    end

    class InvalidDateError < Date::Error
      def message
        'Invalid date/time format or out of range.'
      end
    end
  end

  class KeyBool
    class << self
      def valid?(toml_file)
        KeyBool.invalid_bool(toml_file)
      rescue KeyBool::InvalidBoolError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message)
      end
    end

    def self.invalid_bool(toml_file)
      e = Utils::Error.invalid_bool(toml_file)
      raise InvalidBoolError if e.is_a?(NameError)
    end

    class InvalidBoolError < NameError
      def message
        'Boolean keywords must be all lowercase.'
      end
    end
  end
end
