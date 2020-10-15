class RoomScraper

    def initialize(index_url)
        @doc = Nokogiri::HTML(open(index_url))
        binding.pry
    end

    def rows
        # this line of code is saying that, if @rows already exists leave it be
        # if it does not exist, assign it to what's on the left of our #or= method
        @rows ||= @doc.search("div.content span.rows p.row")
    end
end