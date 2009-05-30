#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'

get '/' do
    haml :index
end

get %r{/about/?} do
    haml :about
end

get %r{/stylesheets/(screen|mobile)/?} do |filename|
    content_type 'text/css', :charset => 'utf-8'
    sass filename.to_sym
end