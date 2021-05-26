#!/usr/bin/env ruby

require_relative '../lib/toml_file'
require_relative '../lib/line'
require_relative '../lib/ultis'

DIR = Dir.pwd
ALL_FILES = Dir.glob('*.toml')

toml_file = TomlFile::TomlLine.new

rgx_comment = Utils::DetectElement.detect_comment
rgx_string = Utils::DetectElement.detect_string
rgx_int = Utils::DetectElement.detect_int

puts "Checking for errors...\n\n"

File.foreach("#{DIR}/#{ALL_FILES[0]}") do |line|
  toml_file.line_to_arr(line)

  if toml_file.line_arr.all?(rgx_comment)
    toml_file.no_comment = false
    Line::Check.comment?(toml_file)
  end

  Line::Check.string?(toml_file) if toml_file.line_arr.all?(rgx_string) && toml_file.no_comment
  Line::Check.int?(toml_file) if toml_file.line_arr.all?(rgx_int) && toml_file.no_comment

  toml_file.no_comment = true
  toml_file.next_line
end

puts "\nNumber of errors found: #{toml_file.error_amount}"
