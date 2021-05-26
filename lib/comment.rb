require_relative '../lib/utils'

module Comment
  class Oneline
    class << self
      def space?(toml_file)
        CommentHandler.check_whitespace(toml_file)
      rescue CommentHandler::NoWhitespaceError => e
        toml_file.new_error
        puts "Error at line #{toml_file.line_number}: #{e.message}"
      end
    end

    class CommentHandler
      @rgx_no_ws = Utils::Error.no_white_space
      class NoWhitespaceError < StandardError
        def message
          'Missing whitespace after #.'
        end
      end

      def self.check_whitespace(toml_file)
        raise NoWhitespaceError if toml_file.line_arr.all?(@rgx_no_ws)
      end
    end
  end
end
