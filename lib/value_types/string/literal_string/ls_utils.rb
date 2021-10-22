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

  def empty_slls?(str)
    return true if CLSLLS.match?(str)
  end

  def mlls_closed?(str)
    MLLSEND.match?(str)
  end

  def slls_closed?(str)
    SLLSEND.match?(str)
  end

  def mlls_chop_ends(str)
    s_str = str.rstrip
    s_str[3, s_str.size - 6]
  end

  def slls_chop_ends(str)
    s_str = str.rstrip
    s_str[1, s_str.size - 2]
  end

  def mlls_valid_quote(str, ind)
    return if str[ind] != SGQ

    bad_group = str[ind, ind.size - 1]
    quote = MTWOASQ.match?(bad_group)
    return UNX_LS_END if quote
  end

  def slls_unx_quote(str, ind)
    return if str[ind] != SGQ

    return UNX_LS_END if UNXSQ.match(str)
  end
end
