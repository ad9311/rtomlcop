#!/usr/bin/env ruby
require_relative '../lib/report_central'

file = '/home/adiaz/Documents/GitHub/rtomlcop/public/sample.toml'

central = ReportCentral.new(file)
central.scan

puts '-------------'
puts '/File Report/'
puts "Last Code: #{central.last_code}"
puts central.report
puts '-------------'
