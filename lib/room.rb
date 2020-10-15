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
        # the reason we don't have this in an #initialize method is because
        # we are scraping this data and it's coming from a hash that we created in our
        # RoomScraper class
        # so we're actually extending the #initialize functionality into our own method
    end

    def save
        persisted? ? update : insert
    end

    def insert
        # I need a database! I think it's my environments job to get my database loaded
        sql = <<-SQL
        INSERT INTO rooms (title, date_created, price, url) VALUES (?, ?, ?, ?)
        SQL

        DB[:connection].execute(sql, self.title, self.date_created, self.price, self.url)
        #puts "You are about to save #{self}"
    end

    def persisted?
        !!self.id
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS rooms (
            id INTEGER PRIMARY KEY,
            title TEXT,
            date_created DATETIME,
            price INTEGER,
            url TEXT
        )
        SQL

        DB[:connection].execute(sql)
    end
end