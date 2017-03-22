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

  # describe ".most_bikes" do
  #   it "returns most bikes available" do
  #     expect( Station.most_bikes ).to eq(10)
  #   end
  # end
  # 
  # describe ".stations_with_most_bikes" do
  #   it "returns a formatted list" do
  #     expect( Station.list_maker([@station1]) ).to eq("LoDo")
  #     expect( Station.list_maker([@station1, @station2, @station3]) ).to eq("LoDo, Five Points, Capital Hill")
  #   end
  #   it "returns stations with most bikes availale" do
  #     expect( Station.stations_with_most_bikes ).to eq("LoDo, Five Points")
  #   end
  # end
  # 
  # describe ".fewest_bikes" do
  #   it "returns fewest bikes available" do
  #     expect( Station.fewest_bikes ).to eq(4)
  #   end
  # end
  # 
  # describe ".stations_with_fewest_bikes" do
  #   it "returns stations with fewest bikes available" do
  #     expect( Station.stations_with_fewest_bikes ).to eq(@station3.name)
  #   end
  # end
  # 
  # describe ".newest_stations" do
  #   it "returns newest stations" do
  #     expect( Station.newest_stations ).to eq(@station3.name)
  #   end
  # end
  # 
  # describe ".oldest_stations" do
  #   it "returns oldest stations" do
  #     expect( Station.oldest_stations ).to eq(@station1.name)
  #   end
  # end

end
