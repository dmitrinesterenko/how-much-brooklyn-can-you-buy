class Listing < ActiveRecord::Base
  #TODO this needs to be cached
  def self.neighborhoods
    #how many queries get run against db
     Listing.where.not(neighborhood: nil).select(:neighborhood, :locality).uniq.order(:locality)

  end

  def self.neighborhoods_by_locality locality
   neighborhoods.where(locality: locality)
  end
end
