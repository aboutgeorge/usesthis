#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'rubygems'
require 'sinatra/base'
require 'datamapper'
require 'rdiscount'
require 'haml'
require 'sass'

require 'lib/interview'
require 'lib/ware'

module UsesThis
    class Base < Sinatra::Base
        set :haml, {:format => :html5}
    
        configure do
            begin
                @database = YAML.load_file('config/database.yml')
            rescue
                puts "Error: Unable to read database config."
                exit
            end
    
            DataMapper.setup(:default, @database)
        end
    
        helpers do
            def current_page
                @page = params[:page] && params[:page].match(/\d+/) ? params[:page].to_i : 1
            end
        end
    end

    class Main < Base
        get '/' do
            @count, @interviews = Interview.paginated(:is_public => true, :page => current_page, :per_page => 5, :order => [:created_at.desc])
            haml :index
        end

        get '/about/?' do
            haml :about
        end

        get '/feed/?' do
            content_type 'application/atom+xml', :charset => 'utf-8'

            @interviews = Interview.all(:order => [:created_at.desc])
            haml :feed, {:format => :xhtml, :layout => false}
        end

        get '/:slug/?' do
            @interview = Interview.first(:slug => params[:slug])
            raise not_found unless @interview

            haml :interview
        end

        not_found do
            haml :error, :locals => { :message => "Man, I suck. I can't find what you're looking for." }
        end

        error do
            haml :error, :locals => { :message => "Something bad happened. It's not you, it's me. Probably." }
        end
    end

    class Admin < Base
        configure do
            begin
                @config = YAML.load_file('config/admin.yml')
            rescue
                puts "Error: Unable to read admin config."
                exit
            end
        end
    
        use Rack::Auth::Basic do |username, password|
            username == @config[:name] && OpenSSL::Digest::SHA1.new(password).hexdigest == @config[:password]
        end
    
        get '/wares/?' do
            @wares = Ware.all(:order => [:slug.asc])
            haml :'wares/index'
        end

        get '/interviews/?' do
            @count, @interviews = Interview.paginated(:page => current_page, :per_page => 10, :order => [:created_at.desc])
            haml :'interviews/index'
        end

        get '/interviews/new' do
            @interview = Interview.new
            haml :'interviews/form', :locals => {:path => '/interviews/new'}
        end

        post '/interviews/new' do
            @interview = Interview.new(params)

            if @interview.save
                redirect '/interviews'
            else
                haml :'interviews/form', :locals => {:path => '/interviews/new'}
            end
        end

        get '/interviews/:slug' do
            @interview = Interview.first(:slug => params[:slug])
            raise not_found unless @interview

            haml :'interviews/form', :locals => {:path => "/interviews/#{params[:slug]}"}
        end

        post '/interviews/:slug' do
            @interview = Interview.first(:slug => params[:slug])
            raise not_found unless @interview

            if @interview.update(params)
                redirect '/interviews'
            else
                haml :'interviews/form', :locals => {:path => "/admin/#{params[:slug]}"}
            end
        end
    end
end