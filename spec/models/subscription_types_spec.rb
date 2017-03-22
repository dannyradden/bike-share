require_relative "../spec_helper"
RSpec.describe SubscriptionType do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Galvanize", dock_count: 1, installation_date: "1/4/1972")
    @condition = Condition.create(date: "29/8/2013", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
    @bike = Bike.create(bike_number: 33)
    @subscription_type = SubscriptionType.create(subscription_type: "Subscriber")
    @zip_code = ZipCode.create(zip_code: 80602)
    @trip = Trip.create(duration: 100, start_date: "29/8/2013 14:14", start_station: @station1, end_date: "29/8/2013 20:14", end_station: @station2, bike: @bike, subscription_type: @subscription_type, zip_code: @zip_code, condition: @condition)
  end

  describe "validations" do
    it "is invalid without a subscription_type" do
      subscription_type = SubscriptionType.create

      expect(subscription_type).to_not be_valid
    end

    it "is valid with subscription type" do
      expect(@subscription_type).to be_valid
    end
  end

  describe "attributes" do
    it "should have subscription_type" do
      expect(@subscription_type).to respond_to(:subscription_type)
    end
  end

  describe ".trips" do
    it "should return trips associated with subscription_type" do
      expect(@subscription_type).to respond_to(:trips)
      expect(@subscription_type.trips).to eq([@trip]) 
    end
  end
end
