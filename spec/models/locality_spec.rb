require 'spec_helper'

describe Locality do
  it "knows how to store a unique locality" do
    l = create(:locality, :name =>"Brooklyn")

    expect(Locality.all.count).to eq(1)
    l1 = build(:locality, :name=>"Brooklyn")
    l1.should_not be_valid
    expect(Locality.all.count).to eq(1)
    l2 = create(:locality, :name=>"Queens")

    expect(Locality.all.count).to eq(2)

  end
end
