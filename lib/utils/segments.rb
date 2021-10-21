require_relative './regexp'

module Segmemts
  include RegExp::Slices

  def segment_line(line_pack)
    table = table_segment(line_pack[1])
    key = key_segment(line_pack[1])
    value = value_segment(line_pack[1])
    comment = comment_segment(line_pack[1])
    {
      num: line_pack[0],
      self: line_pack[1],
      table: table,
      key: key,
      value: value,
      comment: comment
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

  def comment_segment(line)
    line.strip
    line.slice(COMMENT)
  end
end
