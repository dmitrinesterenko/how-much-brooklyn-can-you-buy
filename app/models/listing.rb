class Listing < ActiveRecord::Base
  #TODO this needs to be cached
  def self.neighborhoods
    #how many queries get run against db
    nabes = Listing.where.not(neighborhood: nil).select(:neighborhood, :locality).uniq.order(:locality)
    nabes
  end
end
