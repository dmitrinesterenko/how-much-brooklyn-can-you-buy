require_relative 'spec_helper'

describe RealEstateSpider do
  before(:all) do
    @spider = RealEstateSpider.new.tap do |r|
      r.page = '/NY/Brooklyn/'
    end
   ## pp @spider
  end

  it "No existing records before save" do
    listings = Listing.all
    expect(listings).to be(nil)
    listings = Listing.find_by(neighborhood: "Cobble Hill")
    expect(listings).to be(nil)
  end


  it "Can parse and save all of the listings on the page" do
    @spider.parse
    listings = Listing.all
    expect(listings.count > 0)
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
    #pp "All listings"
    #listings = Listing.all
    #pp listings
    listings = Listing.find_by(neighborhood: "Cobble Hill")
    expect(listings.count > 0)
    pp "Cobble Hill"
    pp listings
  end




end