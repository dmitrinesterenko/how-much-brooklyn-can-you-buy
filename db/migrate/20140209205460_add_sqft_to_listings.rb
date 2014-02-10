class AddSqftToListings < ActiveRecord::Migration
  def change
    add_column :listings, :sqft, :integer
  end
end
