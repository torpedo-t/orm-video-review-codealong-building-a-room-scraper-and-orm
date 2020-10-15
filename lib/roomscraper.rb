class RoomScraper

    def initialize(index_url) # we do it this way, so that when an object is instantiated, it's ready to scrape
        @index_url = index_url
        @doc = Nokogiri::HTML(open(index_url))
        #binding.pry
    end

    def call
        rows.each do |row_doc|
            Room.create_from_hash(scrape_row(row_doc)) # should put the room in my database
            #binding.pry
        end
    end

private
    def rows
        # this line of code is saying that, if @rows already exists leave it be
        # if it does not exist, assign it to what's on the left of our #or= method
        # instance methods (when created, instantiate with a value of nil FYI, unless they're assigned)
        @rows ||= @doc.search("div.content ul.rows li.result-row")
        # .search is searching my @doc for the selectors provided in our argument
    end

    def scrape_row(row)
        #binding.pry
        # scrape an individual row
        { 
            :date_created => row.search("time").attribute("datetime").text, 
            :title => row.search("a.hdrlnk").text, 
            :url => "#{@index_url}#{row.search("a.hdrlnk").attribute("href").text}", 
            :price => row.search("span.price").text
        }
    end
end