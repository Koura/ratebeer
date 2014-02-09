require 'spec_helper'
include OwnTestHelper
include RatingCreatorHelper

describe "Rating" do
  let!(:brewery) {FactoryGirl.create :brewery, name:"Koff"}
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "ratings are shown in the site" do
    ratings = create_beers_with_ratings(10, 20,15,7,9,user)
    visit ratings_path
    expect(page).to have_content "Number of ratings: #{ratings.count}"
    ratings.each do |rating|
      expect(page).to have_content rating
    end 
  end

  it "only users own ratings are shown in his profile" do
    create_beers_with_ratings(10, 20,15,7,9,user)
    user2 = FactoryGirl.create(:user, username:"Japi")
    create_beers_with_ratings(2, user2)
    visit user_path(user)
    user.ratings.each do |rating|
      expect(page).to have_content rating
    end
    expect(page).not_to have_content user2.ratings.first.user.username
  end

  it "deleted rating is removed from the database" do
    create_beers_with_ratings(10, 20,15,7,9,user)
    visit user_path(user)
    rating = user.ratings.first
    expect{
    page.find('li', :text => rating).click_link('delete')
    }.to change{Rating.count}.by(-1)
    visit ratings_path 
    expect(page).not_to have_content rating
  end
end
