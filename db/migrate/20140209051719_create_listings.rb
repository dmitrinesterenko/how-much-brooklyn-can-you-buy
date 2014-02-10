class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :realty_id
      t.string :thumb
      t.string :url
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :locality
      t.float :price
      t.string :zip
      t.string :listing_type
      t.string :neighborhood
      t.string :beds
      t.string :baths


      t.timestamps
    end
  end
end


#{"realty_id"=>"3144688849",
# "geo"=>{"latitude"=>"40.68553", "longitude"=>"-73.94787"},
# "thumb"=>
#     "http://thumbs.trulia-cdn.com/pictures/thumbs_3/ps.59/4/b/6/9/picture-uh=88e4ada53c447ea337d92f2773f5-ps=4b6977dcaae3ed1c87fbde6c4433124f.jpg",
# "address"=>"282 Monroe Street, Brooklyn NY",
# "url"=>"/property/3144688849-282-Monroe-St-Brooklyn-NY-11216",
# "zip"=>"11216",
# "locality"=>"Brooklyn",
# "price"=>899000,
# "listing_type"=>"Resale",
# "neighborhood"=>"Bedford - Stuyvesant",
# "beds"=>"5",
# "baths"=>"3"},
