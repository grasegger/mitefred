#!/usr/bin/env ruby

require './lib.rb'
require 'json'

mymite = get_connection

def get_time_entries(mite_connection)

  items = []

  myself = mite_connection::Myself.find

  mite_connection::TimeEntry.all(:params => {:user_id => myself.id, :from => "last_week", :to => "today"}).each do |entry|

    service = mite_connection::Service.find(entry.service_id)
    project = mite_connection::Project.find(entry.project_id)
  
    entryitem = {
          "uid" => entry.id,
          "title" => entry.note,
          "subtitle" => "#{project.name} - #{service.name}",
          "arg" => entry.id,
          "autocomplete" => "#{entry.note} #{project.name} #{service.name}",
          "icon" => {
              "path" => "icon.png"
          }
      }
      items << entryitem
  end

  JSON.generate({'items': items})
end



unless $cache.exist? 'time_entries'
  $cache.write('time_entries', get_time_entries(mymite), expires_in: 1.hour)
end

puts $cache.read('time_entries')