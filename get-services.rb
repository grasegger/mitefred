#!/usr/bin/env ruby
require './lib.rb'

mymite = get_connection()

items = []
mymite::Service.all.each do |service|
  serviceitem = {
        "uid" => service.id,
        "title" => service.name,
        "arg" => service.id,
        "autocomplete" => service.name,
        "icon" => {
            "path" => "icon.png"
        }
    }
    items << serviceitem
end

puts JSON.generate({'items': items})