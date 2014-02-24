require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
      [ Place.new(name:"Oljenkorsi", id:1) ]
    )
    
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if nothing is returned, appropriate message is shown" do 
    BeermappingApi.stub(:places_in).with("kumpula").and_return([])
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in kumpula"
  end 

  it "if many are returned by the API, they are all shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
      [ Place.new(name:"Oljenkorsi", id:1), Place.new(name:"Unicafe", id:2)]
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Unicafe"
  end
end
