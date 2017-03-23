require_relative "../../spec_helper"

RSpec.describe "When a user visits '/station-dashboard' " do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "LoDo", dock_count: 10, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Five Points", dock_count: 10, installation_date: "15/3/2017")
    @station3 = city.stations.create(name: "Capital Hill", dock_count: 4, installation_date: "16/3/2017")
  end

  it "they see a dashboard message" do
    visit '/station-dashboard'

    within('h1') do
      expect(page).to have_content('Welcome to the Station Dashboard!')
    end

    within('div.total_stations') do
      expect(page).to have_content("Total count of stations: 3")
    end

    within('div.average_bikes') do
      expect(page).to have_content("Average bikes available per station: 8")
    end

    within('div.most_bikes') do
      expect(page).to have_content("Most bikes available at a station: 10")
    end

    within('div.stations_with_most_bikes') do
      expect(page).to have_content("Station(s) where the most bikes are available: Five Points, LoDo")
    end

    within('div.fewest_bikes') do
      expect(page).to have_content("Fewest bikes available at a station: 4")
    end

    within('div.stations_with_fewest_bikes') do
      expect(page).to have_content("Station(s) where the fewest bikes are available: Capital Hill")
    end

    within('div.newest_stations') do
      expect(page).to have_content("Most recently installed station(s): Capital Hill")
    end

    within('div.oldest_stations') do
      expect(page).to have_content("Oldest station(s): LoDo")
    end
  end
end
