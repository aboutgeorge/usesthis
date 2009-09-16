#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'datamapper'

class Ware
    include DataMapper::Resource
    
    property :slug,         String, :key => true
    property :title,        String
    property :url,          String, :length => 100
    property :description,  String, :length => 100
    
    timestamps :at
    
    validates_is_unique :slug
    validates_present :title, :url, :description
    
    has n, :interviews, :through => Resource
end