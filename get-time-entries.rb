#!/usr/bin/env ruby

require './lib.rb'
require 'json'

mymite = get_connection

items = []

myself = mymite::Myself.find

mymite::TimeEntry.all(:params => {:user_id => myself.id, :at => "today"}).each do |entry|

  service = mymite::Service.find(entry.service_id)
  project = mymite::Project.find(entry.project_id)
  
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

puts JSON.generate({'items': items})