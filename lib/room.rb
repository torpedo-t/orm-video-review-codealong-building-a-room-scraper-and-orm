class Room
    attr_accessor :title, :date_created, :price, :url

    def self.create_from_hash(hash) # Instantiate and save
        new_from_hash(hash).save
    end

    def self.new_from_hash(hash) # Just instantiating
        room = self.new
        room.title = hash[:title]
        room.date_created = hash[:date_created]
        room.price = hash[:price]
        room.url = hash[:url]
        room
    end

    def save

    end
end