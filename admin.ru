ENV['RACK_ENV'] = "production"

require File.join(File.dirname(__FILE__), 'admin.rb')
run Sinatra::Application