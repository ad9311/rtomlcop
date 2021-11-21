module Codes
  module Status
    # No Error code
    OK = :ok
    # Skip line
    SKIP = :skip
    # Undefine Value code
    UNDEF = :undef
    # Tests
    TEST = :test
    # Multi-line Basic String code
    MULTI_BS = :multi_bs
    # Multi-line Literal String code
    MULTI_LS = :multi_ls
    # Multi-line codes array
    MULTI = [MULTI_BS, MULTI_LS].freeze
  end

  module TypeOf
    # Value of type String
    STR = :str
    # Value of type Numeric
    NUM = :num
    # Value of type DateTime
    DTT = :dtt
  end

  module Offence
    # String
    # Basic String

    # Major Offence: Unexpected Basic String
    UNX_BS_END = :unexpbs

    # Minor Offence: Invalid escaped character sequence
    INV_ESC_SEQ = :invescseq
    # Minor Offence: Invalid unicode code format
    INV_UNI_FORMAT = :invunifrm
    # Minor Offence: Expected new line after basic string
    EXP_NL_BS = :expnlbs

    # Literal String

    # Major Offence: Unexpected Literal String
    UNX_LS_END = :unexpls
    # Minor Offence: Expected new line after literal string
    EXP_NL_LS = :expnlls

    # Numeric
    # Float

    # Minor Offence: Missing leading number before float
    MSS_LEAD_NUM = :mssleadnum
    # Minor Offence: Extra zeros at the begining of a float
    EXT_ZEROS = :extzeros
    # Minor Offence: Invalid format for float
    INV_FLT_FRMT = :invfltfrmt

    # Integers

    # Minor Offence: Leading Zero for non HEX, OCT and BIN integer numbers
    LEADZERO = :leadzero
    # Minor Offence: Invalid format for integer
    INV_INT_FRMT = :invintfrmt

    # Date Time

    # Minor Offence: Invalid date or time format
    INV_DTT_FRMT = :invdatefrmt

    # Tables & Keys

    # Minor Offence: Duplicate children in table array
    DUP_CHLD = :dupchld
  end
end
