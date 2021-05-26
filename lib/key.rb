require_relative '../lib/ultis'

module Key
  class KeyString
    class << self
      def closed?(toml_file)
        KeyStringHandler.unclosed?(toml_file)
      rescue KeyStringHandler::UnclosedStringError => e
        puts "Error at line #{toml_file.line_number}: #{e.message}"
        toml_file.new_error
      end
    end

    class KeyStringHandler
      @rgx_unclosed = Utils::DetectError.unclosed_string

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
      rescue KeyIntHandler::ZeroPaddedInteger => e
        puts "Error at line #{toml_file.line_number}: #{e.message}"
        toml_file.new_error
      end
    end

    class KeyIntHandler
      @rgx_padded = Utils::DetectError.padded_int

      class ZeroPaddedInteger < StandardError
        def message
          'Zero padding integer.'
        end
      end

      def self.zero_padding(toml_file)
        raise ZeroPaddedInteger if toml_file.line_arr.all?(@rgx_padded)
      end
    end
  end
end
