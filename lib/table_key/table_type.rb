require_relative '../utils/codes'
require_relative './array_table_collection'
require_relative '../offence/major_offence'
require_relative '../offence/minor_offence'

class TableType
  include Codes::Status
  include Codes::Offence

  def initialize
    @lnum = nil
    @offences = []
    @arr_tbl_li = []
    @tbl_li = []
  end

  def insp_table(line)
    tbl_set(line)
    switch_tbl_type(line)
    send_resp
  end

  private

  def tbl_set(line)
    @lnum = line.fetch(:lnum)
    @offences = []
  end

  def switch_tbl_type(line)
    case count_brakets(line)
    when true
      insp_nesting(line)
    when false
      [TES]
    else
      OK
    end
  end

  def send_resp
    return OK if @offences.empty?

    @offences
  end

  def count_brakets(line)
    tbl = line.fetch(:table)
    return true if tbl.nil?

    brakets = tbl.count('[]')
    tbl_major_offnc(UNCL_TBL) if brakets.odd?
    tbl_major_offnc(EXT_BRK) if brakets > 4

    return true if brakets == 4

    false
  end

  def tbl_major_offnc(code)
    raise(MajorOffence.new(@lnum, code))
  end

  def insp_nesting(line)
    unless line.fetch(:table).nil?
      resps = []
      @arr_tbl_li << ArrayTableCollection.new(line)
      resps << @arr_tbl_li.last.insp_collection(@arr_tbl_li)
      apnd_off(resps)
    end
    @arr_tbl_li.last.add_child(line) unless line.fetch(:key).nil?
    @offences
  end

  def apnd_off(resps)
    resps.each do |resp|
      @offences << MinorOffence.new(@lnum, resp) unless resp.nil? || resp == OK
    end
  end
end
