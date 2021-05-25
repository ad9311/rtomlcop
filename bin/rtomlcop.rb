#!/usr/bin/env ruby

# Comment::Comment.check_comment(line, file_line) if line.split('*').all?(/^(\s+|)[#].+./)
# Key::KeyString.closed_string?(line, file_line.line) if line.split('*').all?(/[a-z0-9]+[\s=]+["]+.+/)

require_relative '../lib/toml_file'
require_relative '../lib/comment'
require_relative '../lib/key'

DIR = Dir.pwd
ALL_FILES = Dir.glob('*.toml')

file_line = TomlFile::TomlLine.new

File.foreach("#{DIR}/#{ALL_FILES[0]}") do |line|
  Key::KeyInt.check_int(line, file_line.line)
  file_line.next_line
end
