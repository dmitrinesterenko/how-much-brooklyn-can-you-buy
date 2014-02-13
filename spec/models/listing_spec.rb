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
    #pp nabes
    expect(nabes.count > 1)
    pp nabes
    expect(nabes.first.locality != nil)
    expect(nabes.first.neighborhood != nil)
  end

  it "No null neighbordhoods"  do
    nabes = Listing.neighborhoods.find_by(neighborhood: nil)
    expect(nabes).to eq(nil)
  end


end