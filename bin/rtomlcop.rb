#!/usr/bin/env ruby
require_relative '../lib/toml_file'

file = '/home/adiaz/Documents/GitHub/rtomlcop/public/sample.toml'

toml = TomlFile.new
toml.scan(file)
puts toml.reports
