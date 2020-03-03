#!/usr/bin/env ruby
require './lib.rb'

mymite = get_connection()

def get_services(mite_connection)
  items = []
  
  mite_connection::Service.all.each do |service|
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

  JSON.generate({'items': items})
end


unless $cache.exist? 'services'
  $cache.write('services', get_services(mymite), expires_in: 1.month)
end

puts $cache.read('services')