module Key
  class Key
    class << self
      def closed_string?(key_string, file_line)
        KeyStringHandler.unclosed(key_string)
      rescue KeyStringHandler::UnclosedStringError => e
        puts "Error at line #{file_line}: #{e.message}"
      end
    end
  end

  class KeyStringHandler
    class UnclosedStringError < StandardError
      def message
        'Unclosed string'
      end
    end

    def self.unclosed(key_string)
      raise UnclosedStringError unless key_string.split('*').all?(/[a-z0-9]+[\s=]+["]+.+["]$/)
    end
  end
end
