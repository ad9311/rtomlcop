require_relative './utils/segments'
require_relative './value_types/value_type'
require_relative './utils/codes'

class ReportCentral
  include Codes::Status
  include Segmemts
  attr_reader :report, :last_code

  def initialize(file)
    @file = file
    @report = []
    @unhandled_offence = []
    @last_code = OK

    @value_type = ValueType.new
  end

  def scan
    lnum = 1
    File.foreach(@file) do |rl|
      line = segment_line([lnum, rl])
      call_insp(line)
      lnum += 1
    end
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
    when Offence
      @last_code = resp.last.offence.fetch(:code)
      @report = [*@report, *resp]
    when UnhandledOffence
      p 'Unhandled Offence'
    else
      return @last_code = resp.last if MULTI.include?(resp.last)

      @last_code = OK
    end
  end
end
