#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

%w[rubygems sinatra datamapper haml rdiscount lib/interview lib/ware].each do |lib|
    require lib
end

set :haml, {:format => :html5}

configure do
    @config = YAML.load_file('usesthis.yml')
    DataMapper.setup(:default, @config[:database])
    
    set :admin, @config[:admin]
    enable :sessions
end

helpers do
    def current_page
        @page = params[:page] && params[:page].match(/\d+/) ? params[:page].to_i : 1
    end
    
    def interview_url(interview)
        ENV['RACK_ENV'] == 'production' ? "http://#{interview.slug}.usesthis.com/" : "/#{interview.slug}/"
    end
    
    def needs_auth
        admin = request.env['rack.session'][:admin]
        unless admin && admin[:name] == options.admin[:name] && admin[:password] == options.admin[:password]
            raise not_found
        end
    end
end

get '/' do
    @count, @interviews = Interview.paginated(:published_at.not => nil, :page => current_page, :per_page => 10, :order => [:published_at.desc])
    haml :index
end

get '/about/?' do
    haml :about
end

get '/feed/?' do
    content_type 'application/atom+xml', :charset => 'utf-8'

    @interviews = Interview.all(:published_at.not => nil, :order => [:published_at.desc])
    haml :feed, {:format => :xhtml, :layout => false}
end

get '/login/?' do
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    unless @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials[0] == options.admin[:name] && OpenSSL::Digest::SHA1.new(@auth.credentials[1]).hexdigest == options.admin[:password]
        response['WWW-Authenticate'] = %(Basic realm="The Setup")
        throw :halt, [401, "Don't think I don't love you."]
        return
    end
    
    session[:admin] = options.admin
    
    redirect '/'
end

get '/logout/?' do
    session[:admin] = nil

    redirect '/'
end

get '/new/?' do
    needs_auth
    
    haml :new
end

post '/new/?' do
    needs_auth
    
    @interview = Interview.new
    
    @interview.slug = params[:slug]
    @interview.person = params[:slug]
    @interview.summary = "(Summary)"
    @interview.credits = "(Credits)"
    @interview.contents = <<END
### Who are you and what do you do?

### What hardware do you use?

### And what software?

### What would be your dream setup?
END
    
    if @interview.save
        redirect "/#{@interview.slug}/"
    else
        haml :new
    end
end

get '/:slug/:key/?' do |slug, key|
    needs_auth
    
    @interview = Interview.first(:slug => slug)
    raise not_found unless @interview
    
    eval("@interview.#{key}")
end

post '/:slug/edit/:key/?' do |slug, key|
    needs_auth
    
    @interview = Interview.first(:slug => slug)
    raise not_found unless @interview
    
    @interview.update!(key => params[key])
    result = case key
        when 'contents', 'credits'
            RDiscount.new(params[key]).to_html
        when 'published_at'
            @interview.published_at.strftime("%b %d, %Y")
        else
            params[key]
        end

    @interview.link_to_wares

    result
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