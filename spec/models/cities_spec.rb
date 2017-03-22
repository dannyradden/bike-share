require_relative "../spec_helper"

RSpec.describe City do
  before :each do
    @city = City.new
  end
  describe "validations" do
    it "is invalid without a name" do
      @city.save
      expect(@city).to_not be_valid
    end
    it "should be valid with a name" do
      city = City.create(name: "Denver")
      expect(city).to be_valid
    end
  end
  
  describe "relationships" do
    it "returns Denver when station is created from a city" do
      City.create(name: "Denver")
      station = Station.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017", city_id: 1)
      expect(station.city.name).to eq("Denver") 
    end
  end

  describe "attributes" do
    it "should have name" do
      expect(@city).to respond_to(:name)
    end
  end
end
