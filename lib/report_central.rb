require_relative './value_types/value_type'
require_relative './utils/codes'

class ReportCentral
  include Codes::Status

  def initialize
    @report = []
    @last_code = OK
    @value_type = ValueType.new
  end

  def call_insp(line)
    for_value(line)
    @report
  end

  def for_value(line)
    code = @value_type.insp_value(line)
    offence = new_offence(line, code)
    @report << offence unless offence.nil?
  end

  def new_offence(line, code)
    @last_code = code
    ok = code == OK
    { at: line.fetch(:num), code: code } unless ok
  end

  def on_multi?
    multi_codes = [MULTI_BS, MULTI_LS]
    multi_codes.include?(@last_code)
  end
end
