require_relative '../lib/utils'

module Key
  class KeyString
    class << self
      def closed?(toml_file)
        KeyStringHandler.unclosed?(toml_file)
      rescue KeyStringHandler::UnclosedStringError => e
        toml_file.new_error
        puts "Error at line #{toml_file.line_number}: #{e.message}"
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
        raise UnclosedStringError unless toml_file.line_arr.all?(@rgx_unclosed)
      end
    end
  end

  class KeyInt
    class << self
      def padding?(toml_file)
        KeyIntHandler.zero_padding(toml_file)
      rescue KeyIntHandler::ZeroPaddingError => e
        toml_file.new_error
        puts "Error at line #{toml_file.line_number}: #{e.message}"
      end

      def valid_value?(toml_file)
        KeyIntHandler.invalid_int(toml_file)
      rescue KeyIntHandler::InvalidIntError => e
        toml_file.new_error
        puts "Error at line #{toml_file.line_number}: #{e.message}"
      end
    end

    class KeyIntHandler
      @rgx_padded = Utils::Error.padded_int

      class ZeroPaddingError < StandardError
        def message
          'Zero padding integer.'
        end
      end

      def self.zero_padding(toml_file)
        raise ZeroPaddingError if @rgx_padded.match(toml_file.line)
      end

      class InvalidIntError < ArgumentError
        def message
          'Invalid value for integer.'
        end
      end

      def self.invalid_int(toml_file)
        e = Utils::Value.invalid_int(toml_file)
        raise InvalidIntError if e.is_a?(ArgumentError)
      end
    end
  end

  # class KeyFloat
  #   class InvalidFloatError < ArgumentError
  #     def message
  #       'Invalid value for float.'
  #     end

  #     def self.invalid_float(toml_file)
  #       e = Utils::Value.invalid_int(toml_file)
  #       raise InvalidFloatError if e.is_a?(ArgumentError)
  #     end
  #   end
  # end
end
