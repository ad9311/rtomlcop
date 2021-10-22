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
    # String
    # Basic String
    # Major Offences
    EXP_NL_MLBS = :expnlmlbs # Expecting new line in multi line basic string

    # Minor Offences
    INV_ESC_CHAR = :invescchar # Invalid escaped character
    INV_UNI_FORM = :invuniform # Invalid unicode format
  end
end
