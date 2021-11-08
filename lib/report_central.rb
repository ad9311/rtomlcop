require_relative './utils/segments'
require_relative './utils/codes'
require_relative './value_types/value_type'
require_relative './table/table_key_type'

class ReportCentral
  include Codes::Status
  include Segmemts
  attr_reader :report, :code_list

  def initialize(file)
    @file = file
    @report = []
    @code_list = []
    @on_multi = false

    @val = ValueType.new
    @tblkey = TableKeyType.new
  end

  def scan
    lnum = 1
    File.foreach(@file) do |rl|
      on_multi?
      line = segment_line([lnum, rl], @on_multi)
      call_insp(line)
      lnum += 1
    end
  rescue MajorOffence => e
    @code_list << e.offence.fetch(:code)
    @report = [*report, e]
  end

  def call_insp(line)
    # for_tbl_key(line) unless on_multi?
    for_val(line) if tbl_nil?(line)
  end

  private

  def tbl_nil?(line)
    line.fetch(:table).nil?
  end

  def on_multi?
    @on_multi = MULTI.include?(@code_list.last)
  end

  def for_val(line)
    resp = @val.insp_val(line)
    collect_offences(resp)
  end

  def for_tbl_key(line)
    resp = @tblkey.insp_tblkey(line)
    collect_offences(resp)
  end

  def collect_offences(resp)
    return if resp.last == SKIP

    case resp.last
    when MinorOffence
      @code_list << resp.last.offence.fetch(:code)
      @report = [*@report, *resp]
    else
      return @code_list << resp.last if MULTI.include?(resp.last)

      @code_list << resp.last
    end
  end
end
