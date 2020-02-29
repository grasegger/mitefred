#!/usr/bin/env ruby

require './lib.rb'
require 'json'

mymite = get_connection

items = []

mymite::Project.all.each do |project|
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

puts JSON.generate({'items': items})