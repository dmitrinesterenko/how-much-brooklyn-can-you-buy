class AddNonUniqueIndexByNameToNeighborhoods < ActiveRecord::Migration
  def change
    remove_index :neighborhoods, name: 'neighborhood_name_index'
    add_index :neighborhoods, :name,  { name: 'neighborhood_name_index', order: { name: :desc } }
  end
end
