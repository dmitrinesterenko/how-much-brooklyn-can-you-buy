class AddPublicIdToListing < ActiveRecord::Migration

  def change
    add_column :listings, :public_id, :uuid, :default => "uuid_generate_v4()"
  end
end
