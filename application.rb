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
    DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/database/usesthis.db")
    DataMapper.auto_upgrade!
    
    begin
        @config = YAML.load_file('config/application.yml')
    rescue
        @config = {}
    end
    
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
end

get '/' do
    @page = (params[:page].nil? ? 1 : params[:page]).to_i
    @count, @interviews = Interview.paginated(:page => @page, :per_page => 1)
    haml :index
end

get '/about/?' do
    haml :about
end

get '/feed/?' do
    content_type 'application/atom+xml', :charset => 'utf-8'

    @interviews = Interview.all
    haml :feed, {:format => :xhtml, :layout => false}
end

get '/:slug/?' do
    @interview = Interview.first(:slug => params[:slug])
    raise not_found unless @interview

    haml :'interviews/show'
end

get '/stylesheets/:filename/?' do
    response['Expires'] = (Time.now + ((60 * 60 * 24 * 7) * 8)).httpdate
    content_type 'text/css', :charset => 'utf-8'
    sass :"styles/#{params[:filename]}"
end

### Admin

get '/admin/interviews/?' do
    needs_auth
    
    @interviews = Interview.all
    haml :'interviews/index'
end

get '/admin/interviews/new' do
    @interview = Interview.new
    haml :'interviews/form', :locals => {:path => '/admin/new'}
end

post '/admin/interviews/new' do
    @interview = Interview.new(params)

    if @interview.save
        redirect "/admin/interviews"
    else
        haml :'interviews/form', :locals => {:path => '/admin/new'}
    end
end

get '/admin/interviews/:slug' do
    @interview = Interview.first(:slug => params[:slug])
    raise not_found unless @interview

    haml :'interviews/form', :locals => {:path => "/admin/#{params[:slug]}"}
end

post '/admin/interviews/:slug' do
    @interview = Interview.first(:slug => params[:slug])
    raise not_found unless @interview

    if @interview.update_attributes(params)
        redirect "/admin/interviews"
    else
        haml :'interviews/form', :locals => {:path => "/admin/#{params[:slug]}"}
    end
end

### Errors

not_found do
    haml :error, :locals => { :message => "Sorry, but I can't seem to find what you're looking for!" }
end

error do
    haml :error, :locals => { :message => "Something bad happened. It's not you, it's me." }
end