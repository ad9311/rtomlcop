require_relative '../../../utils/regexp'
require_relative '../../../utils/codes'

module BSUtils
  include RegExp::StringValue
  include Codes::Status
  include Codes::Offence

  SLASH = '\\'.freeze
  DBQ = '"'.freeze
  ESC_CHARS = %w[b t n f r u U " \\].freeze

  def mlbs?(str)
    srt = MLBSSRT.match?(str)
    enx = MLBSEND.match(str)
    return true if srt || enx
  end

  def empty_mlbs?(str)
    return true if CLMLBS.match?(str)
  end

  def empty_slbs?(str)
    return true if CLSLBS.match?(str)
  end

  def mlbs_closed?(str)
    MLBSEND.match?(str)
  end

  def slbs_closed?(str)
    SLBSEND.match?(str)
  end

  def mlbs_chop_ends(str)
    s_str = str.rstrip
    s_str[3, s_str.size - 6]
  end

  def slbs_chop_ends(str)
    s_str = str.rstrip
    s_str[1, s_str.size - 2]
  end

  def mlbs_chseq(str, ind, id)
    return if str[ind] != SLASH

    escaped = id == ind
    return if escaped

    nxt = str[ind + 1]
    valid = ESC_CHARS.include?(nxt)
    return INV_ESC_SEQ unless valid || nxt == "\n"

    (ind + 1)
  end

  def slbs_chseq(str, ind, id)
    return if str[ind] != SLASH

    escaped = id == ind
    return if escaped

    nxt = str[ind + 1]
    valid = ESC_CHARS.include?(nxt)
    return INV_ESC_SEQ unless valid

    (ind + 1)
  end

  def mlbs_quote(str, ind, id)
    return unless str[ind] == DBQ

    escaped = ind == id
    return if escaped

    bad_group = str[ind, str.size - 1]
    return UN_BS_END if MLBSSRT.match?(bad_group)
  end

  def slbs_quote(str, ind, id)
    return unless str[ind] == DBQ

    escaped = ind == id
    return if escaped

    UN_BS_END
  end

  def uni_code_char(str, ind)
    return unless /[uU]/.match?(str[ind]) && str[ind - 1] == '\\'

    uni = str[ind] == 'u' ? str[ind, 5] : str[ind, 9]
    return INV_UNI_FORMAT unless UNICHARHEX.match?(uni)
  end
end
