require_relative './comment'
require_relative './key'
require_relative './utils'

# Calls methods according
# to the variable present
# on the current line.
module Line
  class Check
    class << self
      def comment?(toml_file)
        Utils::Slice.get_comment(toml_file)
        Comment::Oneline.space?(toml_file)
      end

      def string?(toml_file)
        Utils::Slice.join_var_val(toml_file)
        Key::KeyString.closed?(toml_file)
      end

      def numeric?(toml_file)
        Utils::Slice.join_var_val(toml_file)
        value = Utils::Slice.get_value(toml_file)
        case value
        when 'float'
          Key::KeyFloat.valid?(toml_file)
        when 'int'
          Key::KeyInt.valid?(toml_file)
        when 'date_time'
          Key::KeyDate.valid?(toml_file)
        end
      end

      def boolean?(toml_file)
        Utils::Slice.join_var_val(toml_file)
        Key::KeyBool.valid?(toml_file)
      end
    end
  end
end
