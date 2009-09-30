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
    @auth = YAML.load_file(File.join(File.dirname(__FILE__), 'config', 'auth.yml'))
end

helpers do
    def current_page
        @page = params[:page] && params[:page].match(/\d+/) ? params[:page].to_i : 1
    end
end

use Rack::Auth::Basic do |username, password|
    username == @auth[:name] && OpenSSL::Digest::SHA1.new(password).hexdigest == @auth[:password]
end

get '/' do
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