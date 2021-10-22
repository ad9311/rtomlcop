module Codes
  module Status
    OK = :ok # No error
    UNDEF = :undef # Undefine Value
    MULTI_BS = :multi_bs # Multi-line Basic String
    MULTI_LS = :multi_ls # Multi-line Literal String
    MULTI = [MULTI_BS, MULTI_LS].freeze # Array of mutli-line codes
  end

  module TypeOf
    STR = :str # Value of tye String
  end

  module Offence
    # Unhandled
    # Strings
    # Basic String
    UNX_BS_END = :unexpbs # Unexpected Basic String
    # Literal String
    UNX_LS_END = :unexpls # Unexpected Literal String

    # String
    # Basic String
    INV_ESC_SEQ = :invescseq # Invalid escaped character
    INV_UNI_FORMAT = :invunifrm # Invalid unicode format

    # Literal String
    EXP_NL_LS = :expnlls # Expected new line after literal string
  end
end
