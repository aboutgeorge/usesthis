ENV['RACK_ENV'] = "production"

require 'usesthis.rb'
UsesThis::Admin.run!(:port => 4000)
