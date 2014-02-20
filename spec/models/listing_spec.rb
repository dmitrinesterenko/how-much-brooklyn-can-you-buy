require 'spec_helper'

describe Listing do
  let(:neighborhood)    do
    "Williamsburg"
  end
  let(:locality) do
    "Brooklyn"
  end

  let(:price)  { 1000000 }

  it "can create and save a listing"  do
    listing = Listing.new
    listing.address = "16 Monitor st, Brooklyn NY"
    listing.baths = "1.5"
    listing.beds = "1"
    listing.price = 480000
    listing.realty_id = "1233232"
    listing.locality = "Brooklyn"
    listing.save


    listings = Listing.where(realty_id: "1233232").take
    expect(listings != nil)


  end

  it "can retrieve neighborhoods"  do
    nabes = Listing.neighborhoods
    expect(nabes.count > 1)
    expect(nabes.first.locality != nil)
    expect(nabes.first.neighborhood != nil)
  end

  it "does not return null neighbordhoods"  do
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

  it "can retrieve listings to buy up to a price" do
      listings = Listing.find_for_price price, neighborhood
      pp listings
      expect(listings)
      expect(listings.count> 0)
      expect(listings[0].price > 0)
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


end