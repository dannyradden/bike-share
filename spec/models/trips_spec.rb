require_relative "../spec_helper"
RSpec.describe Trip do
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
    it "is invalid without a start date" do
      trip = Trip.create(duration: 100, start_station_id: @station1.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without a start station" do
      trip = Trip.create(duration: 100, start_date: "29/8/2013 14:14", end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without an end date" do
      trip = Trip.create(duration: 100, start_station_id: @station1.id, start_date: "29/8/2013 14:14", end_station_id: @station2.id, bike_id: @bike.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without an end station" do
      trip = Trip.create(duration: 100, start_station_id: @station1.id, start_date: "29/8/2013 14:14", end_date: "29/8/2013 20:14", bike_id: @bike.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without a bike" do
      trip = Trip.create(duration: 100, start_date: "29/8/2013 14:14", start_station_id: @station1.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, subscription_type_id: @subscription_type.id, zip_code_id: @zip_code.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without a subscription type" do
      trip = Trip.create(duration: 100, start_date: "29/8/2013 14:14", start_station_id: @station1.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike.id, zip_code_id: @zip_code.id)

      expect(trip).to_not be_valid
    end

    it "is valid with a duration, start date, end date, end station, bike, subscription type, and zip code" do
      expect(@trip).to be_valid
    end
  end

  describe "attributes" do
    it "should have duration, start_date, start_station, end_date, end_station, bike, subscription_type and zip_code" do
      expect(@trip).to respond_to(:duration)
      expect(@trip).to respond_to(:start_date)
      expect(@trip).to respond_to(:start_station)
      expect(@trip).to respond_to(:end_date)
      expect(@trip).to respond_to(:end_station)
      expect(@trip).to respond_to(:bike)
      expect(@trip).to respond_to(:subscription_type)
      expect(@trip).to respond_to(:zip_code)
      expect(@trip).to respond_to(:condition)
    end
  end

  describe "condition relationship" do
    it "should return condition for that trips start date" do
      expect(@trip.condition).to eq(@condition)
      expect(@trip.condition.date).to eq(@trip.start_date.to_date)
      expect(@trip.condition.max_temp).to eq(30)
    end
  end

  describe "zip_code relationship" do
    it "should return the users zip code for the trip" do
      expect(@trip.zip_code).to eq(@zip_code)
      expect(@trip.zip_code.zip_code).to eq(80602)
    end
  end

  describe "station relationships" do
    it "should return start station for the trip" do
      expect(@trip.start_station).to eq(@station1)
      expect(@trip.start_station.name).to eq(@station1.name)
      expect(@trip.start_station.city).to eq(@station1.city)
    end

    it "should return end station for the trip" do
      expect(@trip.end_station).to eq(@station2)
      expect(@trip.end_station.name).to eq(@station2.name)
      expect(@trip.end_station.city).to eq(@station2.city)
    end
  end

  describe "subscription_type relationship" do
    it "should return the trip subscribtion type" do
      expect(@trip.subscription_type).to eq(@subscription_type)
      expect(@trip.subscription_type.subscription_type).to eq("Subscriber")
    end
  end

  describe "bike relationships" do
    it "should return the single bike for that trip" do
      expect(@trip.bike).to eq (@bike)
    end
  end

end
