require_relative '../lib/utils'
require_relative '../lib/message'

module Comment
  class Oneline
    class << self
      def space?(toml_file)
        CommentHandler.check_whitespace(toml_file)
      rescue CommentHandler::NoWhitespaceError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message)
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
        raise NoWhitespaceError if @rgx_no_ws.match?(toml_file.line)
      end
    end
  end
end
