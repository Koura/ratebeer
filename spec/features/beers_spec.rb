require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create(:brewery, name:"Koff") }
  let!(:style) { FactoryGirl.create(:style) }
 
  before :each do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
  end

  it "when given valid name, is added to the database" do
    fill_in('beer_name', with:'anonymous')
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.by(1)
  end

  it "when given invalid name, user is redirected and error message is shown" do
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "New beer"
  end
end
