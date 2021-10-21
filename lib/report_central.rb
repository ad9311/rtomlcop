require_relative './utils/segments'
require_relative './value_types/value_type'
require_relative './utils/codes'

class ReportCentral
  include Codes::Status
  include Segmemts
  attr_reader :report, :last_code

  def initialize(file)
    @file = file
    @offences = []
    @last_code = OK

    @value_type = ValueType.new
  end

  def scan
    num = 1
    File.foreach(@file) do |rl|
      line = segment_line([num, rl])
      call_insp(line)
      num += 1
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
    new_offence(resp)
  end

  def new_offence(resp)
    return if resp.last == OK

    @last_code = resp.last
    @offences << [*@offences, *resp]
  end
end
