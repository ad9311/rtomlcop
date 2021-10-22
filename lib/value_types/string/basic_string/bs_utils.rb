require_relative '../../../utils/regexp'
require_relative '../../../utils/codes'

module BsUtils
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

    false
  end

  def empty_mlbs?(str)
    return true if CLMLBS.match?(str)

    false
  end

  def mlbs_closed?(str)
    MLBSEND.match?(str)
  end

  def chop_ends(str)
    str.rstrip[3, str.size - 7]
  end

  def chk_esc_char(str, ind, id)
    return if str[ind] != SLASH

    escaped = id == ind
    return if escaped

    nxt = str[ind + 1]
    valid = ESC_CHARS.include?(nxt)
    return INV_ESC_SEQ unless valid || nxt == "\n"

    (ind + 1)
  end

  def chk_mlbs_quote(str, ind, id)
    return unless str[ind] == DBQ

    escaped = ind == id
    return if escaped

    bad_group = str[ind, str.size - 1]
    return EXP_NL_MLBS if MLBSSRT.match?(bad_group)
  end

  def chk_uni_char(str, ind)
    return unless /[uU]/.match?(str[ind])

    uni = str[ind] == 'u' ? str[ind, 4] : str[ind, 8]
    return INV_UNI_FORMAT unless UNICHARHEX.match?(uni)
  end
end
