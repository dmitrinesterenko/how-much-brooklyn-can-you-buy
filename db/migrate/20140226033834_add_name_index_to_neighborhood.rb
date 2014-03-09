class AddNameIndexToNeighborhood < ActiveRecord::Migration
  def change
    add_index :neighborhoods, :name,  { name: 'neighborhood_name_index', unique: true, order: { name: :desc } }
  end
end
