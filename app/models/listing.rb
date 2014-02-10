class Listing < ActiveRecord::Base
  #TODO this needs to be cached
  def self.neighborhoods
    nabes = Listing.select(:neighborhood).uniq
    nabes
  end
end
