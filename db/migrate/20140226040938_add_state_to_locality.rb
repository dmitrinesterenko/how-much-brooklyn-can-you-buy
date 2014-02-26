class AddStateToLocality < ActiveRecord::Migration
  def change
    add_column :localities, :state, :string
  end
end
