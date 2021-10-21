require_relative '../../../utils/regexp'
module BsUtils
  include RegExp::StringValue

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
end
