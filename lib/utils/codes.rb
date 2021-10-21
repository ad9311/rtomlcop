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
    # Minor Offences
    # Basic String
    INV_ESC_CHAR = :invescchar # Invalid escaped character
    INV_UNI_FORM = :invuniform # Invalid unicode format
  end
end
