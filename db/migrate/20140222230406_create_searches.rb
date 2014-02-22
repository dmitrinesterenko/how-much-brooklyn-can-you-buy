class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :area
      t.float :spend

      t.timestamps
    end
  end
end
