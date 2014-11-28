#require File.expand_path("../../config/environment", __FILE__)

namespace :neighborhoods do
  desc "Populate neighborhoods"
  # TODO populate localities first, then get uuids from the locality
  task :populate => :environment do
    neighborhoods =  Listing.neighborhoods
    Neighborhood.delete_all
    neighborhoods.each do |n|
      n1 = Neighborhood.new
      n1.name = n.neighborhood
      n1.save
    end
  end
end
