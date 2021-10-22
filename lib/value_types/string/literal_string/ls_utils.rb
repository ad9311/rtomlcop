require_relative '../../../utils/regexp'
require_relative '../../../utils/codes'

module LSUtils
  include RegExp::StringValue
  include Codes::Status
  include Codes::Offence

  SGQ = "'".freeze

  def mlls?(str)
    srt = MLLSSRT.match?(str)
    enx = MLLSEND.match?(str)
    return true if srt || enx
  end

  def empty_mlls?(str)
    return true if CLMLLS.match?(str)
  end

  def mlls_closed?(str)
    MLLSEND.match?(str)
  end

  def mlls_chop_ends(str)
    str.rstrip[3, str.size - 6]
  end

  def mlls_valid_quote(str)
    quote = MTWOADQ.match?(str)
    return MULTI_LS if quote
  end
end
