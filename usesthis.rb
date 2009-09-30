#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

%w[rubygems sinatra datamapper haml lib/interview lib/ware].each do |lib|
    require lib
end

set :haml, {:format => :html5}

configure do
    DataMapper.setup(:default, YAML.load_file(File.join(File.dirname(__FILE__), 'config', 'database.yml')))
end

helpers do
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