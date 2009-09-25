ENV['RACK_ENV'] = "production"

require 'application.rb'
run Sinatra::Application
