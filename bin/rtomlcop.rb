#!/usr/bin/env ruby

require_relative '../lib/toml_file'
require_relative '../lib/line'
require_relative '../lib/utils'
require_relative '../lib/directory'
require_relative '../lib/message'

file = Directory::FileName.new # Create a new file directory

toml_file = Toml::File.new # Create a new toml file

rgx_comment = Utils::Element.detect_comment # Regexr to detect comments
rgx_string = Utils::Element.detect_string # Regex to detect double quoted strings
rgx_num = Utils::Element.detect_numeric # Regex to detect numeric values (integers, floats & dates)
rgx_bool = Utils::Element.detect_bool # Regex to detect bolean values

file.files.length.times do |f|
  Message::Info.display_check(file.files[f])
  File.foreach(file.full_dir[f]) do |line|
    toml_file.line_to_arr(line) # Saves current line string into toml_file instance
    Line::Check.comment?(toml_file) if rgx_comment.match?(line) # Checks wether current line has a comment
    Line::Check.string?(toml_file) if rgx_string.match?(line) # Checks wether current line has a string
    Line::Check.numeric?(toml_file) if rgx_num.match?(line) # Checks wether current line has a numeric value
    Line::Check.boolean?(toml_file) if rgx_bool.match?(line)
    toml_file.next_line
  end
  Message::Info.display_error_count(file.files[f], toml_file) # Displays number of errors
  toml_file.add_errors
  toml_file.clear
end

Message::Info.display_total_errors(toml_file, file.files.length)
