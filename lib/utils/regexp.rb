require_relative '../utils/codes'

module RegExp
  include Codes::Status
  include Codes::TypeOf

  module Slices
    # Table
    TABLE = Regexp.new(/^\[.*\]/).freeze
    # Key
    KEY = Regexp.new(/.*=(\w\W)*/).freeze
    # Value
    VALUE = Regexp.new(/(?<==)[\w\W]*/).freeze
    # Comment
    COMMENT = Regexp.new(/^#+.*\n$/).freeze
  end

  module ValueFormat
    # String Type
    QUOTES = Regexp.new(/['"]/).freeze
    # Numeric Type
    NUMBER = Regexp.new(/^[\-+.0-9]+/).freeze
    # Especial Float values
    ESPFLT = %w[inf +inf -inf nan +nan -nan].freeze

    def of_type(value)
      return RegExp::STR if QUOTES.match?(value)

      return RegExp::NUM if NUMBER.match?(value) || ESPFLT.include?(value)

      RegExp::UNDEF
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
    SLLSEND = Regexp.new(/'\n$/).freeze
    # More than two adjacent single quotes
    MTWOASQ = Regexp.new(/'{3,}.*/).freeze
    # Unexpected Single Quote
    UNXSQ = Regexp.new(/'{1,}.*/).freeze

    # Unicode Characters Hex Codes
    UNICHARHEX = Regexp.new(/^[uU][0-9a-fA-F]{4,8}$/).freeze
  end

  module NumericValue
    # More than one zero at the beging of a number
    ZEROS = Regexp.new(/^0{2,}/).freeze
  end
end
