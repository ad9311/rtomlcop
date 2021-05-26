#!/usr/bin/env ruby

require_relative '../lib/toml_file'
require_relative '../lib/line'
require_relative '../lib/utils'
require_relative '../lib/flag'

DIR = Dir.pwd
ALL_FILES = Dir.glob('*.toml')

toml_file = Toml::File.new
# flag = Flag::Hold.new

rgx_comment = Utils::Element.detect_comment
rgx_string = Utils::Element.detect_string
rgx_num = Utils::Element.detect_numeric

puts "Checking for errors...\n\n"

File.foreach("#{DIR}/#{ALL_FILES[0]}") do |line|
  toml_file.line_to_arr(line)

  Line::Check.comment?(toml_file) if rgx_comment.match?(line)
  Line::Check.string?(toml_file) if rgx_string.match?(line)
  Line::Check.numeric?(toml_file) if rgx_num.match?(line)

  toml_file.next_line
end

puts "\nNumber of errors found: #{toml_file.error_amount}"
