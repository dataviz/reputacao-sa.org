#!/usr/bin/env ruby

Company.each do |c|
  puts c.complaints.count
end