module Key
  class KeyString
    class << self
      def check_string(key_string, file_line)
        KeyStringHandler.unclosed(key_string)
      rescue KeyStringHandler::UnclosedStringError => e
        puts "Error at line #{file_line}: #{e.message}"
      end
    end
  end

  class KeyStringHandler
    class UnclosedStringError < StandardError
      def message
        'Unclosed string.'
      end
    end

    def self.closed_string(key_string)
      raise UnclosedStringError unless key_string.split('*').all?(/[a-z0-9]+[\s=]+["]+.+["]$/)
    end
  end

  class KeyInt
    class << self
      def check_int(key_int, file_line)
        KeyIntHandler.zero_padding(key_int)
      rescue KeyIntHandler::ZeroPaddedInteger => e
        puts "Error at line #{file_line}: #{e.message}"
      end 
    end

    class KeyIntHandler
      class ZeroPaddedInteger < StandardError
        def message
          'Zero padding integer.'
        end
      end

      def self.zero_padding(key_int)
        raise ZeroPaddedInteger if key_int.split('*').all?(/.+[=][\s]+[0]+[0-9]+/)
      end
    end
  end
end
