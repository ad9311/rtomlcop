require_relative './patterns'

module Segmemts
  include Patterns::Slices

  def segment_line(line_pack)
    table = table_segment(line_pack[1])
    key = key_segment(line_pack[1])
    value = value_segment(line_pack[1])
    {
      lnum: line_pack[0],
      self: line_pack[1],
      table: table,
      key: key,
      value: value
    }
  end

  private

  def table_segment(line)
    line.slice(TABLE)
  end

  def key_segment(line)
    slice = line.slice(KEY)
    slice&.lstrip
  end

  def value_segment(line)
    slice = line.slice(VALUE)
    slice&.lstrip
  end
end
