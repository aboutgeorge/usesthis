ENV['RACK_ENV'] = "production"

require 'usesthis.rb'
UsesThis::Main.run!(:port => 3000)
