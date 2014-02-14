class Listing < ActiveRecord::Base
  #TODO this needs to be cached
  def self.neighborhoods
    #how many queries get run against db
     Listing.where.not(neighborhood: nil).select(:neighborhood, :locality).uniq.order(:locality)

  end

  def self.neighborhoods_by_locality locality
   neighborhoods.where(locality: locality)
  end

  def self.listings_by_neighborhood  neighborhood
    #always return an array even if one is matched for consistency
    listings = Array.new
    if neighborhood && neighborhood != ''
      listings = Listing.find_by(neighborhood: neighborhood)
    else
       listings =Listing.take(100)
    end
    if !defined? listings.count
      [listings]
    else
      listings
    end

  end

  def self.find_for_price total_price, neighborhood = ''
    price_found = 0
    listing_results = Array.new
    listings = listings_by_neighborhood(neighborhood)

    listings.each do |listing|
      price_found = price_found + listing.price
      listing_results << listing
      if total_price >= total_price
        break
      end

    end
    listing_results
  end
end
