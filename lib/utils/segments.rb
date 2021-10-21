require_relative './regexp'

module Segmemts
  include RegExp::Slices

  def fragment_line(raw_line)
    table = table_fragment(raw_line)
    key = key_fragment(raw_line)
    value = value_fragment(raw_line)
    comment = comment_fragment(raw_line)
    [table, key, value, comment]
  end

  private

  def table_fragment(raw_line)
    raw_line.slice(TABLE)
  end

  def key_fragment(raw_line)
    slice = raw_line.slice(KEY)
    slice&.lstrip
  end

  def value_fragment(raw_line)
    slice = raw_line.slice(VALUE)
    slice&.strip
  end

  def comment_fragment(raw_line)
    raw_line.strip
    raw_line.slice(COMMENT)
  end
end
