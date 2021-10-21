#!/usr/bin/env ruby
require_relative '../lib/report_central'

file = '/home/adiaz/Documents/GitHub/rtomlcop/public/sample.toml'

central = ReportCentral.new(file)
central.scan
puts central.report
