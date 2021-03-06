require 'spec_helper'

describe Beer do
  it "is saved with a name and style" do
    beer = Beer.create name:"Dunkers", style:FactoryGirl.create(:style)
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved nameless" do 
    beer = Beer.create style:FactoryGirl.create(:style)
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style (pun intended)" do
    beer = Beer.create name:"Styleless"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
