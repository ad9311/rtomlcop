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
    # Literal String
    UNEXP_LS = :unexpls # Unexpected Literal String

    # String
    # Basic String
    # Major Offences
    EXP_NL_MLBS = :expnlmlbs # Expecting new line after multi line basic string

    # Minor Offences
    INV_ESC_SEQ = :invescseq # Invalid escaped character
    INV_UNI_FORMAT = :invunifrm # Invalid unicode format
  end
end
