#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'datamapper'
require 'dm-is-paginated'

class Interview
    include DataMapper::Resource
    is_paginated
    
    property :id,           Serial
    property :slug,         String
    property :person,       String
    property :summary,      String
    property :credits,      String
    property :who,          Text
    property :hardware,     Text
    property :software,     Text
    property :dream_setup,  Text
    
    timestamps :at
end
