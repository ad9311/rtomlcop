require_relative '../utils/codes'

module Patterns
  include Codes::Status
  include Codes::TypeOf

  module Slices
    # Table
    TABLE = Regexp.new(/^\s*\[.*\]/).freeze
    # Key
    KEY = Regexp.new(/.*=(\w\W)*/).freeze
    # Value
    VALUE = Regexp.new(/(?<==)[\w\W]*/).freeze
    # Comment
    COMMENT = Regexp.new(/\s*?#.*/).freeze
    # Pair closing characters string
    CLOSING_CHARS_STR = "\"'{}[]".freeze
    # Pair closing characters array
    CLOSING_CHARS = ['"', "'", '{', '}', '[', ']'].freeze
  end

  module ValueFormat
    # String Type
    QUOTES = Regexp.new(/['"]/).freeze
    # Numeric Type
    NUMBER = Regexp.new(/[\-+.0-9]+/).freeze # Check Later
    # Especial Float values
    ESPFLT = %w[inf +inf -inf nan +nan -nan].freeze
    # Integer Prefixes
    INTPREFIX = Regexp.new(/[xXoObB]/).freeze
    # Date Time
    DATETIME = Regexp.new(/^[\d\-:TZ]+\n*$/).freeze

    def of_type(value)
      return Patterns::STR if QUOTES.match?(value)

      return Patterns::NUM if numeric?(value)

      return Patterns::DTT if date_time?(value)

      Patterns::UNDEF
    end

    def numeric?(value)
      return false if value.include?(':') || value.count('-') > 1

      numeric = NUMBER.match?(value)
      esp_char = ESPFLT.include?(value)
      prefix = INTPREFIX.match?(value)
      numeric || esp_char || prefix
    end

    def date_time?(value)
      return true if value.include?(':') || value.count('-') > 1

      return true if DATETIME.match?(value)
    end
  end

  module StringValue
    # Start of Basic String
    BSSRT = Regexp.new(/^"{1,}/).freeze
    # End of Basic String
    BSEND = Regexp.new(/"{1,}(\n?)$/).freeze

    # Start of Literal String
    LSSRT = Regexp.new(/^'{1,}/).freeze
    # End of Lietal String
    LSEND = Regexp.new(/'{1,}(\n?)$/).freeze

    # Start of Basic String Multi-line mode
    MLBSSRT = Regexp.new(/^"{3,}/).freeze
    # End of Basic String Multi-line mode
    MLBSEND = Regexp.new(/[^\\]"{3,}(\n?)$/).freeze
    # Start of Basic String Single-line mode
    SLBSEND = Regexp.new(/[^\\]"{1,}(\n?)$/).freeze

    # Start of Literal String Multi-line mode
    MLLSSRT = Regexp.new(/^'{3,}/).freeze
    # End of Literal String Multi-line mode
    MLLSEND = Regexp.new(/[^']'{3,}(\n?)$/).freeze
    # End of Literal String Single-line mode
    SLLSEND = Regexp.new(/'(\n?)$/).freeze
    # More than two adjacent single quotes
    MTWOASQ = Regexp.new(/'{3,}.*/).freeze
    # Unexpected Single Quote
    UNXSQ = Regexp.new(/'{1,}.*/).freeze

    # Unicode Characters Hex Codes
    UNICHARHEX = Regexp.new(/^[uU][0-9a-fA-F]{4,8}$/).freeze
  end

  module NumericValue
    # One of more leading zeros
    ZEROS = Regexp.new(/^0{2,}/).freeze
  end
end
