require 'spec_helper'

describe Neighborhood do
  before(:each) do
   # Neighborhood
  end
  it "knows how to store a unique neighborhood by name" do
    n = create(:neighborhood, :name=>"Greenpoint")
    n.save
    expect(Neighborhood.all.count).to eq(1)

    n1 = Neighborhood.new
    n1.name = "Greenpoint"
    n1.save
    expect(Neighborhood.all.count).to eq(1)

  end

end
