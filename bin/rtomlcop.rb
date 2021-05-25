#!/usr/bin/env ruby
require_relative '../lib/comment'

# DIR = Dir.pwd
# ALL_FILES = Dir.glob('*.toml')

# File.foreach("#{DIR}/#{ALL_FILES[0]}") { |line| puts line }

Comment::Comment.check_comment('#askdjhasdad')
