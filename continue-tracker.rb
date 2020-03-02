#!/usr/bin/env ruby
require './lib.rb'

mymite = get_connection()

time_entry = Mite::TimeEntry.find(ENV['time_entry'])

time_entry.start_tracker