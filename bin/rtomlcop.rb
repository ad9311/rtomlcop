#!/usr/bin/env ruby
require_relative '../lib/report_central'

file = '/home/adiaz/Documents/GitHub/rtomlcop/public/sample.toml'

central = ReportCentral.new(file)
central.scan

puts '-------------'
puts '/File Report/'
puts '-------------'
puts 'offences:'
central.report.each do |o|
  puts "#{o.offence} - #{o.class}"
end
puts '-------------'
puts "Code List:"
puts central.code_list
puts '-------------'
