class Neighborhood < ActiveRecord::Base
  # This is a great way to validate that the neighborhood name is created only once
  # taking into locaity id (this will probably fail in dense urban ares)
  validates_uniqueness_of :name, scope: :locality_id


end
