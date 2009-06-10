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
        attr_accessor :person, :slug, :contents, :date
        
        def self.all
            interviews = []

            Dir.glob(File.join("interviews", "published", "*.markdown")).sort.reverse.each do |path|
                interviews << Setup::Interview.new(path)
            end

            interviews
        end
        
        def self.with_slug(slug)
            files = Dir.glob(File.join("interviews", "published", "*#{slug}.markdown"))
            return nil unless files.length == 1

            Setup::Interview.new(files[0])
        end
        
        def initialize(path)
            matches = %r(/(\d{4,})-(\d{2,})-(\d{2,})-(.+)\.markdown$).match(path)
            return unless matches
            
            contents = File.read(path)
            return if contents.empty?
            
            @person     = contents.slice!(/^(.+)\r?\n\r?\n/).strip
            @contents   = contents            
            @slug       = matches[4].downcase
            @date       = {:year => matches[1], :month => matches[2], :day => matches[3]}
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
                time = Time.now
                contents = File.read(path)
                
                unless contents.empty?
                    contents.gsub!(/### Question (\d)/) do |matches|
                        "### #{questions[$1.to_i-1]}"
                    end
                    
                    contents += "\n\n"
                    
                    links = contents.scan(/\[([^\[\(\)]+)\]\[([a-z0-9\.\-]+)?\]/)
                    links.each do |link|
                        slug = link[1] ? link[1] : link[0].downcase                        
                        if wares["#{slug}"]
                            contents += "[#{slug}]: #{wares[slug]['url']} \"#{wares[slug]['description']}\"\n"
                        end
                    end
                    
                    new_path = File.join("interviews", "published", "#{time.strftime('%Y')}-#{time.strftime('%m')}-#{time.strftime('%d')}-#{File.basename(path)}")
                    File.open(new_path, "w+") do |f|
                        f.write(contents)
                    end                    
                end
            end
        end
    end
    
    class App < Sinatra::Base
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
        end
    end
end