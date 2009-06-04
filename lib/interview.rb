class Interview
    include DataMapper::Resource
    include DataMapper::Timestamp

    property :id, Serial
    property :uuid, String, :length => 36
    property :slug, String
    property :person, String
    property :credits, String
    property :contents, Text
    property :introduction, Text
    property :hardware_used, Text
    property :software_used, Text
    property :dream_setup, Text

    timestamps :at

    property :published_at, DateTime
    
    has n, :wares, :through => Resource
end