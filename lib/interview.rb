#
#    this is usesthis.com, a sinatra application.
#    it is copyright (c) 2009 daniel bogan (d @ waferbaby, then a dot and a 'com')
#

require 'datamapper'
require 'dm-is-paginated'

class Interview
    include DataMapper::Resource
    is_paginated
    
    property :slug,         String, :key => true
    property :person,       String
    property :summary,      String
    property :credits,      String
    property :who,          Text
    property :hardware,     Text
    property :software,     Text
    property :dream_setup,  Text
    
    timestamps :at
    
    validates_is_unique :slug
    validates_present :person, :summary, :who, :hardware, :software, :dream_setup
end
