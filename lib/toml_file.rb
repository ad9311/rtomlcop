require_relative '../lib/report_central'
require_relative '../lib/segments'
class TomlFile
  include Segmemts
  attr_reader :reports

  def initialize
    @reports = []
  end

  def scan(file)
    central = ReportCentral.new
    num = 1
    File.foreach(file) do |raw_line|
      if raw_line != "\n"
        line_fragments = fragment_line(raw_line)
        line = arrange_line(num, raw_line, line_fragments)
        report = central.call_insp(line)
        @reports << report unless report.nil?
      end
      num += 1
    end
  end

  def arrange_line(num, raw_line, line_fragments)
    {
      num: num,
      sefl: raw_line,
      table: line_fragments[0],
      key: line_fragments[1],
      value: line_fragments[2],
      comment: line_fragments[3]
    }
  end
end
