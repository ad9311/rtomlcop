#!/usr/bin/env ruby

require_relative '../lib/toml_file'
require_relative '../lib/line'
require_relative '../lib/utils'
require_relative '../lib/directory'
require_relative '../lib/message'

file = Directory::FileName.new

toml_file = Toml::File.new

rgx_comment = Utils::Element.detect_comment
rgx_string = Utils::Element.detect_string
rgx_num = Utils::Element.detect_numeric
rgx_bool = Utils::Element.detect_bool

file.files.length.times do |f|
  Message::Info.display_check(file.files[f])
  File.foreach(file.full_dir[f]) do |line|
    toml_file.line_to_arr(line)
    Line::Check.comment?(toml_file) if rgx_comment.match?(line)
    Line::Check.string?(toml_file) if rgx_string.match?(line)
    Line::Check.numeric?(toml_file) if rgx_num.match?(line)
    Line::Check.boolean?(toml_file) if rgx_bool.match?(line)
    toml_file.next_line
  end
  Message::Info.display_error_count(file.files[f], toml_file)
  toml_file.add_errors
  toml_file.clear
end

Message::Info.display_total_errors(toml_file, file.files.length)
