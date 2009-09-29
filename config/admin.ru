ENV['RACK_ENV'] = "production"

require 'usesthis.rb'
UsesThisAdmin.run!(:port => 4000)
