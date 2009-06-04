class Ware
    include DataMapper::Resource
    include DataMapper::Timestamp

    property :id, Serial
    property :uuid, String, :length => 36
    property :slug, String
    property :type, Discriminator
    property :name, String
    property :url, String
    property :description, String
    
    belongs_to :creator

    timestamps :at
end

class Hardware < Ware
end

class Software < Ware
end