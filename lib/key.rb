require_relative '../lib/utils'
require_relative '../lib/message'
require 'date'

module Key
  # Class for string values
  class KeyString
    class << self
      # Checks if there is an existing unclosed string
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

  # Class for Integeres including binary, hex, and octal
  class KeyInt
    class << self
      def which_type?(toml_file)
        value = toml_file.value_arr[0]
        sig = value[0] + value[1] + value[2]
        case sig # Returns what integer type
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

      # Receives error if integer is 0-padded or not valid
      def valid?(toml_file)
        KeyIntHandler.zero_padding(toml_file)
        KeyIntHandler.invalid_int(toml_file)
      rescue KeyIntHandler::ZeroPaddingError => e
        toml_file.new_error
      rescue KeyIntHandler::InvalidIntError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message(toml_file))
      end
    end

    # Class for integer errors
    class KeyIntHandler
      def self.zero_padding(toml_file)
        raise ZeroPaddingError if Utils::Error.padded_int(toml_file)
      end

      def self.invalid_int(toml_file)
        e = Utils::Error.invalid_int(toml_file) # Calls method to parse possible incorrect integer value
        raise InvalidIntError if e.is_a?(ArgumentError)
      end

      class ZeroPaddingError < StandardError
        def message
          'Zero padding integer found.'
        end
      end

      class InvalidIntError < ArgumentError
        def message(toml_file)
          char = KeyInt.which_type?(toml_file)
          type = toml_file.value_arr[3]
          msg = "Invalid #{type} value. \"#{char}\" character not permitted."
          msg
        end
      end
    end
  end

  # Class for float values
  class KeyFloat
    class << self
      def valid?(toml_file)
        KeyFloat.invalid_float(toml_file) # Checks for incorrect float
      rescue KeyFloat::InvalidFloatError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message)
      end
    end
    # Calls method to parse possible incorrect float
    def self.invalid_float(toml_file)
      e = Utils::Error.invalid_float(toml_file)
      raise InvalidFloatError if e.is_a?(ArgumentError)
    end

    # Class for float error
    class InvalidFloatError < ArgumentError
      def message
        'Invalid value for float.'
      end
    end
  end

  # Class for dates and time
  class KeyDate
    class << self
      # Raise error if incorrect date format found
      def valid?(toml_file)
        KeyDate.invalid_date(toml_file)
      rescue KeyDate::InvalidDateError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message)
      end
    end

    def self.invalid_date(toml_file)
      e = Utils::Error.invalid_date(toml_file) # Calls method to parse date
      raise InvalidDateError if e.is_a?(Date::Error)
    end

    class InvalidDateError < Date::Error
      def message
        'Invalid date/time format'
      end
    end
  end
end
