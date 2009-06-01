#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'rubygems'
require 'sinatra'
require 'datamapper'
require 'haml'
require 'sass'

configure do
    
    begin
        config = YAML.load_file('application.yml')

        DataMapper.setup(:default, config[:datamapper])
    	DataMapper::Logger.new(STDOUT, :debug)
    	
    	Dir.glob('lib/*.rb') do |filename|
    	    require filename
	    end
    	
    rescue Exception => e
        puts "Error: #{e}"
        exit
    end
end

get '/' do
    @interviews = Interview.all
    haml :index
end

get %r{/(.+)/?} do
end

get %r{/about/?} do
    haml :about
end

get %r{/stylesheets/(screen|mobile)/?} do |filename|
    content_type 'text/css', :charset => 'utf-8'
    sass filename.to_sym
end