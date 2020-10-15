class RoomScraper

    def initialize(index_url)
        @doc = Nokogiri::HTML(open(index_url))
        binding.pry
    end

    def call
        rows.each do |row_doc|
            scrape_row(row_doc)
        end
    end

private
    def rows
        # this line of code is saying that, if @rows already exists leave it be
        # if it does not exist, assign it to what's on the left of our #or= method
        # instance methods (when created, instantiate with a value of nil FYI, unless they're assigned)
        @rows ||= @doc.search("div.content span.rows p.row")
        # .search is searching my @doc for the selectors provided in our argument
    end

    def scrape_row(row)
        # scrape an individual row
        {
         :date_created => row.search("time")
         :title => row.search("a.hdrlnk").text
         :url => row.search("a.hdrlnk").attribute("href")
         :price => row.search("span.price").text
        }
        # my goal is to end up with a hash of key value pairs of our attributes
    end
end