require 'spec_helper'

describe Search do
  it "Can save a search" do
    search = Search.new.tap do  |s|
      s.area = 'Middle Earth'
      s.spend = 1000000000000
    end
    search.save
    searches = Search.find_by(area: 'Middle Earth')
    expect(searches)
    expect(searches.spend).to eq(1000000000000)
  end
end
