require_relative './comment'
require_relative './key'
require_relative './ultis'

module Line
  class Check
    class << self
      # Check if comment has a space between # symbol
      def comment?(toml_file)
        Comment::Oneline.space?(toml_file)
      end

      # Check line has a key with an unclosed string as a value
      def string?(toml_file)
        Key::KeyString.closed?(toml_file)
      end

      # Check line is a key with a numeric value
      def int?(toml_file)
        Key::KeyInt.padding?(toml_file)
        Key::KeyInt.valid_value?(toml_file)
      end
    end
  end
end
