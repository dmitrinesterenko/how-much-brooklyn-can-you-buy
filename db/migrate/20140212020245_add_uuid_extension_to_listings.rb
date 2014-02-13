class AddUuidExtensionToListings < ActiveRecord::Migration
  def self.up
    execute "CREATE EXTENSION \"uuid-ossp\";"
  end

  def self.down
    execute "DROP EXTENSION \"uuid-ossp\";"
  end
end
