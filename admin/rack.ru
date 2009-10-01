ENV['RACK_ENV'] = "production"

require File.join(File.dirname(__FILE__), 'application.rb')
run Sinatra::Application