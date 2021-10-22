require_relative './utils/segments'
require_relative './value_types/value_type'
require_relative './utils/codes'

class ReportCentral
  include Codes::Status
  include Segmemts
  attr_reader :report, :code_list

  def initialize(file)
    @file = file
    @report = []
    @code_list = []

    @value_type = ValueType.new
  end

  def scan
    lnum = 1
    File.foreach(@file) do |rl|
      line = segment_line([lnum, rl])
      call_insp(line)
      lnum += 1
    end
  rescue MajorOffence => e
    @code_list << e.offence.fetch(:code)
    @report = [*report, e]
  end

  def call_insp(line)
    for_value(line)
  end

  private

  def for_value(line)
    resp = @value_type.insp_value(line)
    collect_offences(resp)
  end

  def collect_offences(resp)
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
