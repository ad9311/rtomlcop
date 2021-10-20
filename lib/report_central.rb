require_relative '../lib/utils/codes'
class ReportCentral
  include Codes::Status

  def initialize
    @report = []
  end

  def call_insp(line)
    @report
  end
end
