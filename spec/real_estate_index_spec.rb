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
    expect(listings.count).to be(0)
    listings = Listing.find_by(neighborhood: "Cobble Hill")
    expect(listings).to be(nil)
  end


  it "can parse and save all of the listings on the page" do
    @spider.parse
    listings = Listing.all
    expect(listings.count > 0)
  end

  it "knows how many pages of real estate listings there are " do
    expect(@spider.num_pages).to be > 0

  end

  it "knows how to scrub many pages" do
    parse_pages 3
    listings = Listing.all
    expect(listings.count > 0).to eq(true)
    #pp listings
    #below tests for neighborhood, too strict and data may not fulfill that expectation
    #listings = Listing.find_by(neighborhood: "Cobble Hill")
    #pp "Cobble Hill"
    #pp listings
  end

  it "can parse neighborhoods from listings" do
    parse_pages 3
    listings = Listing.all
    expect(Listing.neighborhoods.count > 0).to eq(true)
  end

  def parse_pages pages
    @spider.parse
    sleep(0.5)
    pages.times do |i|
      interval = (rand(100)+10)/100.0
      puts "Interval #{interval}"
      next if i==0 || i==1
      url = "/NY/Brooklyn/p_#{i}/"
      @spider.get_next_page url
      listings = @spider.parse
      pp listings
      sleep(interval)
    end
  end


end
