ENV['RACK_ENV'] = "production"

require 'application.rb'
run Setup::App.new
