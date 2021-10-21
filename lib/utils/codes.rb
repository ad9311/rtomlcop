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
end
