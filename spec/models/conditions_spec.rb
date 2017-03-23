require_relative "../spec_helper"
RSpec.describe Condition do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Galvanize", dock_count: 1, installation_date: "1/4/1972")
    @bike = Bike.create(bike_number: 33)
    @subscription_type = SubscriptionType.create(subscription_type: "Subscriber")
    @zip_code = ZipCode.create(zip_code: 80602)
    @trip = Trip.create(duration: 100, start_date: "29/8/2013 14:14", start_station: @station1, end_date: "29/8/2013 20:14", end_station: @station2, bike: @bike, subscription_type: @subscription_type, zip_code: @zip_code)
  end

  describe "validations" do
    it "is invalid without a date" do
      conditions_for_date = Condition.new(max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
      expect(conditions_for_date).to_not be_valid
    end

    it "is invalid without a maximum temperature" do
      conditions_for_date = Condition.new(date: "14/3/2017", min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
      expect(conditions_for_date).to_not be_valid
    end

    it "is invalid without a minimum temperature" do
      conditions_for_date = Condition.new(date: "14/3/2017", max_temp: 30.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
      expect(conditions_for_date).to_not be_valid
    end

    it "is invalid without a mean temperature" do
      conditions_for_date = Condition.new(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
      expect(conditions_for_date).to_not be_valid
    end

    it "is invalid without a mean humidity" do
      conditions_for_date = Condition.new(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
      expect(conditions_for_date).to_not be_valid
    end

    it "is invalid without a mean visibility" do
      conditions_for_date = Condition.new(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_wind_speed: 12.0, precipitation: 0.03)
      expect(conditions_for_date).to_not be_valid
    end

    it "is invalid without a mean wind speed" do
      conditions_for_date = Condition.new(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, precipitation: 0.03)
      expect(conditions_for_date).to_not be_valid
    end

    it "is invalid without precipitation" do
      conditions_for_date = Condition.new(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0)
      expect(conditions_for_date).to_not be_valid
    end

    it "should be valid with a date, max_temp, min_temp, mean_temp, mean_humidity, mean_visibility, mean_wind_speed, and precipitation" do
      conditions_for_date = Condition.create(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
      expect(conditions_for_date).to be_valid
    end
  end

  describe "relationships" do
    it "should return multiple trips" do
      conditions_for_date = Condition.create(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
      conditions_for_date.trips.create(duration: 100, start_date: "14/3/2017 14:14", start_station: @station1, end_date: "29/8/2013 20:14", end_station: @station2, bike: @bike, subscription_type: @subscription_type, zip_code: @zip_code)
      conditions_for_date.trips.create(duration: 200, start_date: "14/3/2017 14:14", start_station: @station1, end_date: "29/8/2013 20:14", end_station: @station2, bike: @bike, subscription_type: @subscription_type, zip_code: @zip_code)

      expect(conditions_for_date.trips.count).to eq(2)
      expect(conditions_for_date.trips.first.duration).to eq(100)
    end
  end


  describe "attributes" do
    it "should have name, city, dock count, and an installation date" do
      conditions_for_date = Condition.new
      expect(conditions_for_date).to respond_to(:date)
      expect(conditions_for_date).to respond_to(:max_temp)
      expect(conditions_for_date).to respond_to(:min_temp)
      expect(conditions_for_date).to respond_to(:mean_temp)
      expect(conditions_for_date).to respond_to(:mean_humidity)
      expect(conditions_for_date).to respond_to(:mean_visibility)
      expect(conditions_for_date).to respond_to(:mean_wind_speed)
      expect(conditions_for_date).to respond_to(:precipitation)
    end
  end
end
