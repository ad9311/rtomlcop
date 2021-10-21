require_relative '../../../utils/regexp'
module BsUtils
  include RegExp::StringValue

  def mlbs?(str)
    srt = MLBSSRT.match?(str)
    enx = MLBSEND.match(str)
    return true if srt || enx

    false
  end

  def bs_closed?(str)
    two = CLSLBS.match?(str)
    six = CLMLBS.match?(str)
    return true if two || six
  end
end
