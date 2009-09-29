ENV['RACK_ENV'] = "production"

require 'usesthis.rb'
UsesThis.run!(:port => 3000)
