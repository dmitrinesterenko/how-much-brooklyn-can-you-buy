class AlterRealtyIdToBigInt < ActiveRecord::Migration
  def self.up
    change_column :listings, :realty_id, :bigint
  end

  def self.down
    change_column :listings, :realty_id, :int
  end
end
