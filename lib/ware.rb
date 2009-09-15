#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'datamapper'

class Ware
    include DataMapper::Resource
    
    property :id,           Serial
    property :title,        String
    property :url,          String, :length => 100
    property :description,  String
    
    timestamps :at
end