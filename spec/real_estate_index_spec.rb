require_relative 'spec_helper'

describe RealEstateSpider do
  before(:all) do
    @spider = RealEstateSpider.new.tap do |r|
      r.page = '/NY/Brooklyn/'
    end
   ## pp @spider
  end

  it "Can retrieve existing records before save" do
    listings = Listing.all
    puts 'All listings before parse'
    pp listings
    expect(listings.count > 0)
    listings = Listing.find_by(neighborhood: "Cobble Hill")
    puts 'Cobble Hill'
    pp listings
    expect(listings.count > 0)
  end


  it "Can parse all of the listings on the page" do
    @spider.parse
    listings = Listing.all
    #pp listings
    #puts listings.count
  end

  it "Knows how many pages of real estate listings there are " do
    expect(@spider.num_pages).to be > 0

  end

  it "Knows how to scrub many pages" do

    @spider.parse

    sleep(0.5)
    @spider.num_pages.times do |i|
      r = rand(100)+10
      interval = r / 100.0
      puts "Interval #{interval}"
      if i==0 || i==1
        next
      end
      if i > 3
        break
      end
      url = "/NY/Brooklyn/p_#{i}/"
      @spider.get_next_page url
      listings = @spider.parse
      #pp listings
      sleep(interval)
    end
    pp "All listings"
    listings = Listing.all
    pp listings
    listings = Listing.find_by(neighborhood: "Cobble Hill")
    pp "Cobble Hill"
    pp listings
  end

  it "Can retrieve existing records after parse" do
    listings = Listing.all
    puts 'All listings after parse'
    pp listings
    expect(listings.count > 0)
    listings = Listing.find_by(neighborhood: "Cobble Hill")
    puts 'Cobble Hill'
    pp listings
    expect(listings.count > 0)
  end


end