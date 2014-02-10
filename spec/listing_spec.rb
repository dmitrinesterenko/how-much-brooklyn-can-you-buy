require_relative 'spec_helper'

describe Listing do

  it "Can create and save a listing"  do
    listing = Listing.new
    listing.address = "16 Monitor st, Brooklyn NY"
    listing.baths = "1.5"
    listing.beds = "1"
    listing.price = 480000
    listing.realty_id = "1233232"
    listing.save

    listings = Listing.where(realty_id: "1233232").take
    pp listings
    expect(listings != nil)


  end

end