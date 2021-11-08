require_relative './patterns'

module Segmemts
  include Patterns::Slices

  def segment_line(line_pack, on_multi)
    table = nil
    key = nil
    value = nil
    unless on_multi
      table = remove_comment(table_segment(line_pack[1]))
      key = key_segment(line_pack[1])
      value = remove_comment(value_segment(line_pack[1]))
    end
    {
      lnum: line_pack[0],
      self: line_pack[1],
      table: table,
      key: key,
      value: value
    }
  end

  def remove_comment(value)
    return value unless value&.include?('#')

    unless value.count(CLOSING_CHARS_STR).positive?
      comment = value.slice(COMMENT)
      return new_value = value.split(comment)[0]
    end

    new_value = nil
    size = value.size
    size.times do |ind|
      r_ind = (size - ind - 1)
      quote = CLOSING_CHARS.include?(value[r_ind])
      if quote
        comment = value[r_ind + 1, value.size]
        return new_value = value.split(comment)[0]
      end
    end
    new_value
  end

  private

  def table_segment(line)
    line.slice(TABLE)
  end

  def key_segment(line)
    slice = line.slice(KEY)
    return if slice.nil?

    key = slice.split('=')[0]
    key&.strip
  end

  def value_segment(line)
    slice = line.slice(VALUE)
    slice&.lstrip
  end
end
