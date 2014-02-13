require 'spec_helper'

describe ApiController, :type => :api do
   let(:neighborhoods)    { '/api/neighborhoods/'}
   it "Retrieves all of the neighborhoods" do
     neighborhoods = Listing.neighborhoods
     get :neighborhoods
     assigns(:api_samples).should eq([neighborhoods])
     #assigns(:nabes)
     #pp nabes
     puts response
     expect(response.status).to eq(200)
     puts @response.body
   end


end