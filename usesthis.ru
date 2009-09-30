ENV['RACK_ENV'] = "production"

require File.join(File.dirname(__FILE__), 'usesthis.rb')
run Sinatra::Application