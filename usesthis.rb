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
        
        DataMapper.setup(:default, config[:database][p.environment])
    	
        Dir.glob('lib/*.rb') do |filename|
            require filename
	    end
	    
    rescue Exception => e
        puts "Error: #{e}"
        exit
    end
end

helpers do    
    def markup(text, filter_html = true)
        return "" unless text
        
        markdown = RDiscount.new(text)
        markdown.filter_html = filter_html
        
        markdown.to_html
    end
    
    def content_for(interview)
        content  = "### Who are you and what do you do?\n"
        content += "#{interview.introduction}\n\n"
        content += "### What hardware do you use?\n"
        content += "#{interview.hardware_used}\n\n"
        content += "### And what software?\n"
        content += "#{interview.software_used}\n\n"
        content += "### What would be your dream setup?\n"
        content += "#{interview.dream_setup}"

        if interview.wares.length > 0
            content += "\n\n"

            interview.wares.each do |ware|
                content += "[#{ware.slug}]: #{ware.url} \"#{ware.description}\"\n"
            end
        end

        content
    end
end

get '/' do
    @interviews = Interview.all(:order => [:created_at.desc])
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