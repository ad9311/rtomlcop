require_relative './report_central'
require_relative './utils/segments'
class TomlFile
  include Segmemts

  def initialize
    @central = ReportCentral.new
  end

  def scan(file)
    num = 1
    File.foreach(file) do |raw_line|
      if raw_line != "\n"
        line_fragments = fragment_line(raw_line)
        line = arrange_line(num, raw_line, line_fragments)
        report = @central.call_insp(line)
      end
      num += 1
    end
  end

  private

  def arrange_line(num, raw_line, line_fragments)
    {
      num: num,
      self: raw_line,
      table: line_fragments[0],
      key: line_fragments[1],
      value: line_fragments[2],
      comment: line_fragments[3]
    }
  end
end
