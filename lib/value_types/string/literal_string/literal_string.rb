require_relative '../../../utils/codes'
require_relative './ls_utils'

class LiteralString
  include Codes::Status
  include LSUtils

  def initialize
    @str = nil
    @lnum = 0
    @last_code = OK
  end

  def insp_ls(line)
    incr_ls_lnum(line) if @last_code == OK
    concat_ls(line)
    arr_ls_resp(switch_mlls(@str))
  end

  private

  def incr_ls_lnum(line)
    @lnum = line.fetch(:lnum)
  end

  def concat_ls(line)
    @str = line.fetch(:value) unless MULTI.include?(@last_code)
    return unless MULTI.include?(@last_code)

    str = line.fetch(:self)
    @str.concat(str)
  end

  def switch_mlls(str)
    con = mlls?(str)
    @last_code = MULTI_LS if con
    case con || mllscode?
    when true
      mlls(str)
    else
      slls(str)
    end
  end

  def arr_ls_resp(resp)
    case resp
    when Array
      @last_code = OK
      resp
    else
      @last_code = OK unless MULTI.include?(resp)
      [resp]
    end
  end

  def mllscode?
    MULTI.include?(@last_code)
  end

  def lnum_ls_offset(str, ind)
    @lnum += 1 if str[ind] == "\n"
  end

  def mlls(str)
    return OK if empty_mlls?(str)

    return @last_code = MULTI_LS unless mlls_closed?(str)

    insp_mlls(str)
  end

  def slls(str)
    return OK if empty_slls?(str)
    return @last_code = ls_minor_offnc(EXP_NL_LS) unless slls_closed?(str)

    insp_slls(str)
  end

  def insp_mlls(str)
    s_str = mlls_chop_ends(str)
    s_str.size.times do |ind|
      lnum_ls_offset(s_str, ind)
      ls_major_offnc(mlls_valid_quote(s_str, ind))
    end
    OK
  end

  def insp_slls(str)
    s_str = slls_chop_ends(str)
    s_str.size.times do |ind|
      ls_major_offnc(slls_unx_quote(s_str, ind))
    end
    OK
  end

  def ls_minor_offnc(code)
    MinorOffence.new(@lnum, code) if code.is_a?(Symbol)
  end

  def ls_major_offnc(code)
    return unless code.is_a?(Symbol)

    raise(MajorOffence.new(@lnum, code))
  end
end
