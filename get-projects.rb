#!/usr/bin/env ruby

require './lib.rb'
require 'json'

mymite = get_connection

def get_projects(mite_connection)
  items = []
    
  mite_connection::Project.all.each do |project|
    projectitem = {
          "uid" => project.id,
          "title" => project.name,
          "subtitle" => project.name,
          "arg" => project.id,
          "autocomplete" => project.name,
          "icon" => {
              "path" => "icon.png"
          }
      }
      items << projectitem
  end
  
  JSON.generate({'items': items})
end

unless $cache.exist? 'projects'
  $cache.write('projects', get_projects(mymite), expires_in: 1.day)
end

puts $cache.read('projects')