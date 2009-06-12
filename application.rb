#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'rubygems'
require 'sinatra/base'
require 'rdiscount'
require 'haml'
require 'sass'

module Setup
    class Interview
        attr_accessor :person, :slug, :contents, :created_at, :updated_at
        
        def self.all
            interviews = []

            Dir.glob(File.join("interviews", "published", "*.markdown")).each do |path|
                interviews << Setup::Interview.new(path)
            end

            interviews.sort{ |a, b| b.created_at <=> a.created_at }
        end
        
        def self.with_slug(slug)
            file = File.join("interviews", "published", "#{slug}.markdown")
            return nil unless File.exist?(file)

            Setup::Interview.new(file)
        end
        
        def initialize(path)
            contents = File.read(path)
            return if contents.empty?
            
            details = contents.slice!(/^(.+)\r?\n\r?\n/).split(" @ ")
            
            @person     = details[0]
            @slug       = File.basename(path, ".markdown")
            @contents   = contents
            @created_at = DateTime.parse(details[1])
            @updated_at = DateTime.parse(File.mtime(path).to_s)
        end
    end
    
    class Publisher
        def self.run
            wares = YAML.load_file(File.join("data", "wares.yml"))

            questions = [
                "Who are you and what do you do?",
                "What hardware do you use?",
                "And what software?",
                "What would be your dream setup?"
            ]
            
            Dir.glob(File.join("interviews", "drafts", "*.markdown")) do |path|
                contents = File.read(path)
                
                unless contents.empty?
                    contents.sub!(/^(.+)\r\n\r\n/, '\1' + " @ #{DateTime.now.to_s}\r\n\r\n")
                    contents.gsub!(/### Question (\d)/) do |match|
                        "### #{questions[$1.to_i-1]}"
                    end
                    
                    links = contents.scan(/\[([^\[\(\)]+)\]\[([a-z0-9\.\-]+)?\]/)
                    if links.length > 0
                        contents += "\n\n"
                        
                        links.each do |link|
                            slug = link[1] ? link[1] : link[0].downcase                        
                            if wares["#{slug}"]
                                contents += "[#{slug}]: #{wares[slug]['url']} \"#{wares[slug]['description']}\"\n"
                            end
                        end
                    end
                    
                    new_path = File.join("interviews", "published", File.basename(path))
                    File.open(new_path, "w+") do |f|
                        f.write(contents)
                    end 
                    
                    File.unlink(path)
                end
            end
        end
    end
    
    class App < Sinatra::Base
        set :haml, { :format => :html5 }
        
        helpers do
            def markup(string)
                markdown = RDiscount.new(string)
                markdown.filter_html = false

                markdown.to_html
            end
        end
        
        get '/' do
            @interviews = Interview.all
            haml :index
        end

        get '/about/?' do
            haml :about
        end

        get '/feed/?' do
            content_type 'application/atom+xml', :charset => 'utf-8'
            
            @interviews = Interview.all
            haml :feed, :layout => false
        end

        get '/:slug/?' do |slug|
            @interview = Interview.with_slug(slug)
            raise not_found unless @interview
            
            haml :interview
        end

        get '/stylesheets/:filename/?' do |filename|
            content_type 'text/css', :charset => 'utf-8'
            sass filename.to_sym
        end

        not_found do
            haml :error, :locals => { :message => "Sorry, but I can't seem to find what you're looking for!" }
        end
        
        error do
            haml :error, :locals => { :message => "Something bad happened. It's not you, it's me." }
        end
    end
end