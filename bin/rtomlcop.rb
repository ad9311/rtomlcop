#!/usr/bin/env ruby
require_relative '../lib/comment'
require_relative '../lib/key'

DIR = Dir.pwd
ALL_FILES = Dir.glob('*.toml')

file_line = 1
File.foreach("#{DIR}/#{ALL_FILES[0]}") do |line|

  Comment::Comment.check_comment(line, file_line) if line.split('*').all?(/^(\s+|)[#].+./)
  Key::Key.closed_string?(line, file_line) if line.split('*').all?(/[a-z0-9]+[\s=]+["]+.+/)
  file_line += 1
end
