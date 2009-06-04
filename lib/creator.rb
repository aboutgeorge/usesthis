class Creator
    include DataMapper::Resource
    include DataMapper::Timestamp

    property :id, Serial
    property :uuid, String, :length => 36
    property :slug, String
    property :name, String
    property :url, String
    
    has n, :wares

    timestamps :at
end