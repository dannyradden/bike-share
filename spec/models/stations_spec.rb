require_relative "../spec_helper"
RSpec.describe Station do
  before :each do
    @city = City.create(name: "Denver")
  end

  describe "validations" do
    it "is invalid without a name" do
      station = @city.stations.new(dock_count: 100, installation_date: "14/3/2017")
      expect(station).to_not be_valid
    end

    it "is invalid without a city" do
      station = Station.new(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
      expect(station).to_not be_valid
    end

    it "is invalid without a dock count" do
      station = @city.stations.new(name: "Turing", installation_date: "14/3/2017")
      expect(station).to_not be_valid
    end

    it "is invalid without an installation date" do
      station = @city.stations.new(name: "Turing", dock_count: 100)
      expect(station).to_not be_valid
    end

    it "should be valid with a name, city, dock_count, and installation_date" do
      station = @city.stations.new(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
      expect(station).to be_valid
    end
  end
  
  describe "relationships" do
    it "returns stations when city is created from station" do
      Station.create(name: "Memorial Union", dock_count: 100, installation_date: "14/3/2017", city_id: 1)
      expect(@city.stations.first.name).to eq("Memorial Union") 
    end

    it "a station should have a start and end trips attached to it" do
      @station1 = @city.stations.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
      @station2 = @city.stations.create(name: "Galvanize", dock_count: 1, installation_date: "1/4/1972")
      @bike = Bike.create(bike_number: 33)
      @subscription_type = SubscriptionType.create(subscription_type: "Subscriber")
      @zip_code = ZipCode.create(zip_code: 80602)
      @trip1 = Trip.create(duration: 100, start_date: "29/8/2013 14:14", start_station_id: @station1.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)
      @trip2 = Trip.create(duration: 200, start_date: "29/8/2013 14:14", start_station_id: @station1.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)
      @trip3 = Trip.create(duration: 300, start_date: "29/8/2013 14:14", start_station_id: @station2.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)

      expect(@station1.start_trips).to eq([@trip1, @trip2])
      expect(@station2.end_trips).to eq([@trip1, @trip2, @trip3])

      # expect(station.end_station.name).to eq('Galvanize')
    end
  end

  describe "attributes" do
    it "should have name, city, dock count, and an installation date" do
      station = Station.new
      expect(station).to respond_to(:name)
      expect(station).to respond_to(:city)
      expect(station).to respond_to(:dock_count)
      expect(station).to respond_to(:installation_date)
    end
  end
end
