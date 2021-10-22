require_relative '../utils/codes'

module RegExp
  include Codes::Status
  include Codes::TypeOf

  module Slices
    TABLE = Regexp.new(/^\[.*\]/).freeze
    KEY = Regexp.new(/.*=(\w\W)*/).freeze
    VALUE = Regexp.new(/(?<==)[\w\W]*/).freeze
    COMMENT = Regexp.new(/^#+.*\n$/).freeze
  end

  module ValueFormat
    QUOTES = Regexp.new(/['"]/).freeze

    def of_type(value)
      type = RegExp::UNDEF
      type_str = string_type(value)
      type = type_str unless type_str.nil?
      type
    end

    def string_type(value)
      return RegExp::STR if QUOTES.match?(value)
    end
  end

  module StringValue
    # String Type
    # Basic String Recognition
    BSSRT = Regexp.new(/^"{1,}/).freeze
    BSEND = Regexp.new(/"{1,}(\n?)$/).freeze

    # Literal String Recognition
    LSSRT = Regexp.new(/^'{1,}/).freeze
    LSEND = Regexp.new(/'{1,}(\n?)$/).freeze

    # Basic Strings multi line and single line
    MLBSSRT = Regexp.new(/^"{3,}/).freeze
    MLBSEND = Regexp.new(/[^\\]"{3,}(\n?)$/).freeze
    SLBSSRT = Regexp.new(/^"{1,}/).freeze # Check later.
    SLBSEND = Regexp.new(/[^\\]"{1,}(\n?)$/).freeze
    CLMLBS = Regexp.new(/^"{6}(\n?)$/).freeze
    CLSLBS = Regexp.new(/^"{2}(\n?)$/).freeze

    # Literal Strings multi line and single line
    MLLSSRT = Regexp.new(/^'{3,}/).freeze
    MLLSEND = Regexp.new(/[^']'{3,}(\n?)$/).freeze
    CLMLLS = Regexp.new(/^[^\n]'{6}(\n?)$/).freeze
    CLSLLS = Regexp.new(/^'{2}(\n?)$/).freeze
    MTWOADQ = Regexp.new(/'{3,}.*/).freeze

    # Unicode Characters Hex Codes
    UNICHARHEX = Regexp.new(/^[uU][0-9a-fA-F]{4,8}$/).freeze
  end
end
