require 'spec_helper'

describe "Beer" do

  before :each do
    FactoryGirl.create :brewery
    visit new_beer_path
  end
  it "when given valid name, is added to the database" do
    fill_in('beer[name]', with:'anonymous')
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "when given invalid name, user is redirected and error message is shown" do
    click_button("Create Beer")
    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end
end
