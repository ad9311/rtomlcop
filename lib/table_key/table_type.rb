require_relative '../utils/codes'
require_relative './array_table_collection'
require_relative '../offence/major_offence'

class TableType
  include Codes::Status
  include Codes::Offence

  def initialize
    @offences = []
    @arr_tbl_li = []
    @tbl_li =[]
  end

  def insp_table(line)
    switch_tbl_type(line)
  end

  private

  def switch_tbl_type(line)
    case count_brakets(line)
    when true 
      nest = insp_nesting(line)
      [*nest]
    when false
      [TES]
    else
      OK
    end
  end

  def count_brakets(line)
    tbl = line.fetch(:table)
    return OK if tbl.nil?

    brakets = tbl.count("[]")
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
      @arr_tbl_li << ArrayTableCollection.new(line)
      @offences << @arr_tbl_li.last.insp_collection(@arr_tbl_li)
    end
    @arr_tbl_li.last.add_child(line) unless line.fetch(:key).nil?
    @offences
  end
end
