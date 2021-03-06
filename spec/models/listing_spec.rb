require 'spec_helper'

describe Listing do
  let(:neighborhood)    do
    "Williamsburg"
  end
  let(:locality) do
    "Brooklyn"
  end

  let(:price)  { 1000000 }

  before(:each) do
	  create_listing
  end
  def create_listing
    listing = Listing.new
    listing.address = "16 Monitor st, Brooklyn NY"
    listing.baths = "1.5"
    listing.beds = "1"
    listing.price = 480000
    listing.realty_id = "1233232"
    listing.locality = "Brooklyn"
    listing.neighborhood = neighborhood
    listing.save
  end

  it "can create and save a listing"  do
    listings = Listing.where(realty_id: "1233232").take
    expect(listings != nil)


  end

  it "can retrieve neighborhoods"  do
    nabes = Listing.neighborhoods
    expect(nabes.count > 1)
    expect(nabes.first.locality != nil)
    expect(nabes.first.neighborhood != nil)
  end

  it "does not return null neighborhoods"  do
    nabes = Listing.neighborhoods.find_by(neighborhood: nil)
    expect(nabes).to eq(nil)
  end

  it "can retrieve neighborhoods by a locality (borough)" do
    nabes = Listing.neighborhoods_by_locality locality
    expect(nabes.count > 1)
    expect(nabes.first.locality).to eq(locality)
  end

  it "can retrieve listings by neighborhood" do
    listings = Listing.listings_by_neighborhood neighborhood
    expect(listings)
    expect(listings.count > 0)
    expect(listings[0].price > 0)


  end

  it "can retrieve listings to buy up to a price, with sqft, bedrooms and baths" do
      listings = Listing.find_for_price price, neighborhood
      real_listings =  listings[0]
      expect(real_listings)
      expect(real_listings.count> 0)
      expect(real_listings[0].price > 0)
      #sqft
      expect(listings[1] > 0)
      #beds
      expect(listings[2] > 0)
      #baths
      expect(listings[3] > 0)
  end

  it "can does not retrieve any listings with 0 price"  do
    listings = Listing.find_for_price price, neighborhood
    listings[0].each do |listing|
        if listing.price == 0
          expect 1==2
        end
    end
  end


  it "can find the total price for a neighborhood" do
    listing_total = Listing.total neighborhood
    expect(listing_total.count > 0)
    pp listing_total

  end

  it "can find the average price for a neighborhood" do
    average = Listing.average neighborhood
    expect(average > 0)
    pp average
  end

  it "can search for a neighborhood or locality by string in the beginning of the neighborhood of borough" do
     listing = Listing.new
     listing.neighborhood = 'Brooklyn'
     listing.save
     nabe_name_1 = 'Broo'
     neighborhood = Listing.autocomplete nabe_name_1
     expect(neighborhood.length > 0).to be(true)

    #check for capitals, without capitals letters should return same as with capitalization
     nabe_name_2= 'broo'
     neighborhoods_2 = Listing.autocomplete nabe_name_2
     expect(neighborhoods_2.length).to eq(neighborhood.length)
     #nabe_name_2 = 'Silv'
     #neighborhoods = Listing.autocomplete nabe_name_2
     #expect(neighborhoods.count > 0)

  end


end
