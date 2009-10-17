#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

%w[rubygems sinatra datamapper haml lib/interview lib/ware].each do |lib|
    require lib
end

set :haml, {:format => :html5}

configure do
    @config = YAML.load_file('usesthis.yml')
    DataMapper.setup(:default, @config[:database])
end

helpers do
    def current_page
        @page = params[:page] && params[:page].match(/\d+/) ? params[:page].to_i : 1
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