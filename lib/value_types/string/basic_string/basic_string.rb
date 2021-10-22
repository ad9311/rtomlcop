require_relative '../../../utils/codes'
require_relative './bs_utils'
require_relative '../../../utils/offence'

class BasicString
  include Codes::Status
  include BsUtils

  def initialize
    @str = nil
    @lnum = 0
    @last_code = OK
  end

  def insp_bs(line)
    incr_bs_lnum(line) if @last_code == OK
    concat_bs(line)
    arr_bs_resp(switch_mlbs(@str))
  end

  private

  def incr_bs_lnum(line)
    @lnum = line.fetch(:lnum)
  end

  def concat_bs(line)
    @str = line.fetch(:value) unless MULTI.include?(@last_code)
    return unless MULTI.include?(@last_code)

    str = line.fetch(:self)
    @str.concat(str)
  end

  def switch_mlbs(str)
    con = mlbs?(str)
    @last_code = MULTI_BS if con
    case con || mlcode?
    when true
      mlbs(str)
    else
      slbs(str)
    end
  end

  def arr_bs_resp(resp)
    unless resp.is_a?(Array)
      @last_code = OK unless MULTI.include?(resp)
      return [resp]
    end
    @last_code = OK
    resp
  end

  def mlcode?
    MULTI.include?(@last_code)
  end

  def lnum_bs_offset(str, ind)
    @lnum += 1 if str[ind] == "\n"
  end

  def mlbs(str)
    return OK if empty_mlbs?(str)

    return @last_code = MULTI_BS unless mlbs_closed?(str)

    insp_mlbs(str)
  end

  def slbs(str)
    return OK if empty_slbs?(str)

    return @last_code = MULTI_BS unless slbs_closed?(str)

    insp_slbs(str)
  end

  def insp_mlbs(str)
    offences = []
    stack = []
    s_str = mlbs_chop_ends(str)
    s_str.size.times do |ind|
      lnum_bs_offset(s_str, ind)

      chseq = mlbs_chseq(s_str, ind, stack.last)
      stack << chseq unless chseq.nil? || chseq.is_a?(Symbol)
      offences << Offence.create(@lnum, chseq)

      unicode = uni_code_char(s_str, ind)
      offences << Offence.create(@lnum, unicode)

      quote = mlbs_quote(s_str, ind, stack.last)
      offences << Offence.create(@lnum, quote)
      break if quote.is_a?(Symbol)
    end
    offences.compact!
    return offences unless offences.empty?

    OK
  end

  def insp_slbs(str)
    offences = []
    stack = []
    s_str = slbs_chop_ends(str)
    s_str.size.times do |ind|
      chseq = slbs_chseq(s_str, ind, stack.last)
      stack << chseq unless chseq.nil? || chseq.is_a?(Symbol)
      offences << Offence.create(@lnum, chseq)

      unicode = uni_code_char(s_str, ind)
      offences << Offence.create(@lnum, unicode)

      quote = slbs_quote(s_str, ind, stack.last)
      offences << Offence.create(@lnum, quote)
      break if quote.is_a?(Symbol)
    end
    offences.compact!
    return offences unless offences.empty?

    OK
  end
end
