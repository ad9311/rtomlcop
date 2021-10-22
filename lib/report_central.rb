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
    @offences = []
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
    @report = @offences
  end

  def call_insp(line)
    for_value(line)
  end

  private

  def for_value(line)
    resp = @value_type.insp_value(line)
    on_multi = MULTI.include?(resp.last)
    if on_multi
      @last_code = resp.last
      return
    end
    collect_offences(resp)
  end

  def collect_offences(resp)
    # @last_code = resp.last.is_a?(Hash) ? resp.last.fetch(:code) : resp.last
    # return if resp.last == OK

    # @offences = [*@offences, *resp]
  end
end
