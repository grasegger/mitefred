#!/usr/bin/env ruby
require './lib.rb'

mymite = get_connection()

time_entry = Mite::TimeEntry.new()
time_entry.project = Mite::Project.find(ENV['project_id'])
time_entry.service = Mite::Service.find(ENV['service_id'])

if ENV.include?('note')
  time_entry.note = ENV['note']
end

time_entry.save
time_entry.start_tracker