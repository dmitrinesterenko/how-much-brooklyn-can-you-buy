class AddLocalityIdToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :locality_id, :uuid
  end
end
