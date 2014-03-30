class Listing < ActiveRecord::Base

  has_paper_trail

  #TODO this needs to be cached
  def self.neighborhoods
    #how many queries get run against db
     Listing.where.not(neighborhood: nil).select(:neighborhood, :locality).uniq.order(:locality)

  end

  def self.localities
    localities = Listing.where.not(locality: nil).select(:locality).uniq.order(:locality)
    localities_filtered = Array.new
    localities.each do |locality|
      locality_up_case = locality.locality.upcase
      if !localities_filtered.include?  locality_up_case
        localities_filtered << locality_up_case
      end
    end
    localities_filtered
  end

  def self.neighborhoods_by_locality locality
   neighborhoods.where(locality: locality)
  end

  def self.listings_by_neighborhood  neighborhood
    #always return an array even if one is matched for consistency
    listings = Array.new
    pp 'neighborhood'
    pp neighborhood
    area = neighborhood.split(' - ')
    if area.length > 1
      locality = area[0]
      neighborhood = area[1]

    end
    if neighborhood && neighborhood != '' && locality && locality != ''
      listings = Listing.where(neighborhood: neighborhood, locality:locality)
    elsif neighborhood && neighborhood != ''
      listings = Listing.where(neighborhood: neighborhood)
    else
       listings =Listing.take(100)
    end
    pp listings
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
    search = Search.new.tap do  |s|
      s.area = neighborhood
      s.spend = total_price
    end
    search.save
    sqft = 0
    beds = 0
    baths = 0
    listings.each do |listing|
      price_found = price_found + listing.price
      if price_found >= total_price
        break
      end
      listing_results << listing
      sqft = sqft + listing.sqft.to_i
      beds = beds + listing.beds.to_f
      baths = baths + listing.baths.to_f

    end
    [listing_results, sqft, beds, baths]
  end

  def self.total neighborhood
    listings = listings_by_neighborhood neighborhood
    pp "In total"
    pp listings
    total = 0
    count = 0
    listings.each do |listing|
      total = total + listing.price
      count = count + 1
    end
    [total, count]
  end




  def self.average neighborhood
    total, count = total neighborhood
    total.to_i.to_f / count.to_f
  end

  def self.autocomplete input_string

    areas = Listing.where("lower(neighborhood) like '%#{input_string.downcase}%'").select(:neighborhood, :locality) .uniq(:neighborhood)
    #this should merge with locality like %input% as well
    areas
  end


end
