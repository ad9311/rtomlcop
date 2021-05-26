#!/usr/bin/env ruby

require_relative '../lib/toml_file'
require_relative '../lib/line'
require_relative '../lib/ultis'

DIR = Dir.pwd
ALL_FILES = Dir.glob('*.toml')

toml_file = TomlFile::TomlLine.new

File.foreach("#{DIR}/#{ALL_FILES[0]}") do |line|
  toml_file.line_to_arr(line)
  Line::Check.comment?(toml_file, line)
  Line::Check.string?(toml_file, line)
  Line::Check.int?(toml_file, line)
  toml_file.next_line
end

puts "Number of errors found: #{toml_file.error_amount}"
