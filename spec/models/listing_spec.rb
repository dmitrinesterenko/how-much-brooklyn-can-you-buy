require 'spec_helper'

describe Listing do

  it "Can create and save a listing"  do
    listing = Listing.new
    listing.address = "16 Monitor st, Brooklyn NY"
    listing.baths = "1.5"
    listing.beds = "1"
    listing.price = 480000
    listing.realty_id = "1233232"
    listing.locality = "Brooklyn"
    listing.save


    listings = Listing.where(realty_id: "1233232").take
    pp listings
    expect(listings != nil)


  end

  it "Can retrieve neighborhoods"  do
    nabes = Listing.neighborhoods
    expect(nabes.count > 1)
    expect(nabes.first.locality != nil)
    expect(nabes.first.neighborhood != nil)
  end

  it "Does not return null neighbordhoods"  do
    nabes = Listing.neighborhoods.find_by(neighborhood: nil)
    expect(nabes).to eq(nil)
  end

  it "Can retrieve neighborhoods by a locality (borough)" do
    nabes = Listing.neighborhoods_by_locality 'Brooklyn'
    expect(nabes.count > 1)
    expect(nabes.first.locality).to eq('Brooklyn')
  end


end