require_relative "../spec_helper"

RSpec.describe Station do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "LoDo", dock_count: 10, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Five Points", dock_count: 10, installation_date: "15/3/2017")
    @station3 = city.stations.create(name: "Capital Hill", dock_count: 4, installation_date: "16/3/2017")
  end

  describe ".total_stations" do
    it "returns total number of stations" do
      expect( Station.total_stations ).to eq(3)
    end
  end

  describe ".average_bikes_available" do
    it "returns average number of bikes available" do
      expect( Station.average_bikes ).to eq(8)
    end
  end

end
