require 'spec_helper'

describe Neighborhood do
  before(:each) do
   # Neighborhood
  end
  it "knows how to store a unique neighborhood by name" do
    n = create(:neighborhood, :name=>"Greenpoint")

    expect(Neighborhood.all.count).to eq(1)

    n1 = FactoryGirl.build(:neighborhood, :name=>"Greenpoint")
    n1.should_not be_valid


  end

end
