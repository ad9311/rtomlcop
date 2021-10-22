module Codes
  module Status
    # No Error code
    OK = :ok
    # Undefine Value code
    UNDEF = :undef
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
  end

  module Offence
    # String
    # Basic String

    # Major Offence: Unexpected Basic String
    UNX_BS_END = :unexpbs 
    
    # Minor Offence Invalid escaped character sequence
    INV_ESC_SEQ = :invescseq
    # Minor Offence Invalid unicode code format
    INV_UNI_FORMAT = :invunifrm

    # Literal String

    # Major Offence: Unexpected Literal String
    UNX_LS_END = :unexpls
    # Minor Offence Expected new line after literal string
    EXP_NL_LS = :expnlls
  end
end
