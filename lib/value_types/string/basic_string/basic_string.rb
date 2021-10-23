require_relative '../../../utils/codes'
require_relative './bs_utils'
require_relative '../../../offence/minor_offence'
require_relative '../../../offence/major_offence'

class BasicString
  include Codes::Status
  include BSUtils

  def initialize
    @str = nil
    @lnum = 0
    @offences = []
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
    unless MULTI.include?(@last_code)
      @str = line.fetch(:value)
      return unless MULTI.include?(@last_code)
    end
    str = line.fetch(:self)
    @str.concat(str)
  end

  def switch_mlbs(str)
    con = mlbs?(str)
    @last_code = MULTI_BS if con
    case con || mlbscode?
    when true
      mlbs(str)
    else
      slbs(str)
    end
  end

  def arr_bs_resp(resp)
    case resp
    when Array
      @last_code = OK
      offences = resp.clone
      @offences.clear
      offences
    when Symbol
      @last_code = OK unless MULTI.include?(resp)
      [resp]
    else
      @last_code = OK
    end
  end

  def mlbscode?
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

    return @last_code = bs_minor_offnc(EXP_NL_BS) unless slbs_closed?(str)

    insp_slbs(str)
  end

  def insp_mlbs(str)
    stack = []
    s_str = mlbs_chop_ends(str)
    s_str.size.times do |ind|
      lnum_bs_offset(s_str, ind)

      chseq = mlbs_chseq(s_str, ind, stack.last)
      stack << chseq unless chseq.nil? || chseq.is_a?(Symbol)
      bs_minor_offnc(chseq)

      unicode = uni_code_char(s_str, ind)
      bs_minor_offnc(unicode)

      bs_major_offnc(mlbs_quote(s_str, ind, stack.last))
    end
    send_bs_offnc
  end

  def insp_slbs(str)
    stack = []
    s_str = slbs_chop_ends(str)
    s_str.size.times do |ind|
      chseq = slbs_chseq(s_str, ind, stack.last)
      stack << chseq unless chseq.nil? || chseq.is_a?(Symbol)
      bs_minor_offnc(chseq)

      unicode = uni_code_char(s_str, ind)
      bs_minor_offnc(unicode)

      bs_major_offnc(slbs_quote(s_str, ind, stack.last))
    end
    send_bs_offnc
  end

  def bs_minor_offnc(code)
    @offences << MinorOffence.new(@lnum, code) if code.is_a?(Symbol)
  end

  def bs_major_offnc(code)
    return unless code.is_a?(Symbol)

    raise(MajorOffence.new(@lnum, code))
  end

  def send_bs_offnc
    return @offences unless @offences.empty?

    OK
  end
end
