class Locality < ActiveRecord::Base
  has_paper_trail
  # This is a way to ensure a record is only generate if it is unique for name-state combination
  validates_uniqueness_of :name, scope: :state
end
