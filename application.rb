#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'rubygems'
require 'sinatra'
require 'datamapper'
require 'haml'
require 'sass'
require 'rdiscount'

configure do |p|    
    begin
        config = YAML.load_file('application.yml')
        
        DataMapper.setup(:default, config[:datamapper][p.environment])
        DataMapper::Logger.new(STDOUT, :debug)
    	
        Dir.glob('lib/*.rb') do |filename|
            require filename
	    end
	    
    rescue Exception => e
        puts "Error: #{e}"
        exit
    end
end

helpers do    
    def markup(text)
        RDiscount.new(text).to_html
    end
end

get '/' do
    @interviews = Interview.all
    haml :index
end

get '/about/?' do
end

get '/feed/?' do
end

get '/:slug/?' do |slug|
    @interview = Interview.first(:slug => slug)
    raise not_found unless @interview
    
    haml :interview
end

get '/stylesheets/:filename/?' do |filename|
    content_type 'text/css', :charset => 'utf-8'
    sass filename.to_sym
end

not_found do
end