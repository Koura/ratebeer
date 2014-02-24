require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
      [ Place.new(:name => "Oljenkorsi") ]
    )
    
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if nothing is returned, appropriate message is shown" do 
    BeermappingApi.stub(:places_in).with("hakaniemi").and_return([])
    visit places_path
    fill_in('city', with: 'hakaniemi')
    click_button "Search"
    expect(page).to have_content "No locations in hakaniemi"
  end 

  it "if many are returned by the API, they are all shown at the page" do
    BeermappingApi.stub(:places_in).with("kamppi").and_return(
      [ Place.new(:name => "Teerenpeli"), Place.new(:name => "Señorita"), Place.new(:name => "DTM") ]
    )
    visit places_path
    fill_in('city', with: 'kamppi')
    click_button "Search"

    expect(page).to have_content "Teerenpeli"
    expect(page).to have_content "Señorita"
    expect(page).to have_content "DTM"
  end
end