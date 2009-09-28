#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'rubygems'
require 'sinatra'
require 'datamapper'
require 'rdiscount'
require 'haml'
require 'sass'

require 'lib/interview'
require 'lib/ware'

set :haml, {:format => :html5}

configure do
    begin
        @config = YAML.load_file('config/application.yml')
    rescue
        puts "Error: Unable to read config file."
        exit
    end
    
    DataMapper.setup(:default, @config[:database])
    
    set :config, @config
end

helpers do
    def needs_auth
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        unless @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials[0] == options.config[:admin][:name] && OpenSSL::Digest::SHA1.new(@auth.credentials[1]).hexdigest == options.config[:admin][:password]
            response['WWW-Authenticate'] = %(Basic realm="The Setup")
            throw :halt, [401, "Don't think I don't love you."]
            return
        end
    end
    
    def markup(string)
        markdown = RDiscount.new(string)
        markdown.filter_html = false

        markdown.to_html
    end
    
    def current_page
        @page = params[:page] && params[:page].match(/\d+/) ? params[:page].to_i : 1
    end
end

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
    @interview = Interview.first(:slug => params[:slug], :is_public => true)
    raise not_found unless @interview

    haml :'interviews/show'
end

### Admin

get '/admin/wares/?' do
    needs_auth
    
    @wares = Ware.all(:order => [:slug.asc])
    haml :'wares/index'
end

get '/admin/interviews/?' do
    needs_auth
    
    @interviews = Interview.all(:order => [:created_at.desc])
    haml :'interviews/index'
end

get '/admin/interviews/new' do
    needs_auth
    
    @interview = Interview.new
    haml :'interviews/form', :locals => {:path => '/admin/new'}
end

post '/admin/interviews/new' do
    needs_auth
    
    @interview = Interview.new(params)

    if @interview.save
        redirect "/admin/interviews"
    else
        haml :'interviews/form', :locals => {:path => '/admin/new'}
    end
end

get '/admin/interviews/:slug' do
    needs_auth
    
    @interview = Interview.first(:slug => params[:slug])
    raise not_found unless @interview

    haml :'interviews/form', :locals => {:path => "/admin/#{params[:slug]}"}
end

post '/admin/interviews/:slug' do
    needs_auth
    
    @interview = Interview.first(:slug => params[:slug])
    raise not_found unless @interview

    if @interview.update(params)
        redirect '/admin/interviews'
    else
        haml :'interviews/form', :locals => {:path => "/admin/#{params[:slug]}"}
    end
end

### Errors

not_found do
    haml :error, :locals => { :message => "Man, I suck. I can't find what you're looking for." }
end

error do
    haml :error, :locals => { :message => "Something bad happened. It's not you, it's me. Probably." }
end