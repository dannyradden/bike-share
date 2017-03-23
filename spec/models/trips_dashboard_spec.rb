require_relative "../spec_helper"

RSpec.describe Trip do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Galvanize", dock_count: 1, installation_date: "1/4/1972")
    @bike1 = Bike.create(bike_number: 33)
    @bike2 = Bike.create(bike_number: 44)
    subscription_type1 = SubscriptionType.create(subscription_type: "Subscriber")
    subscription_type2 = SubscriptionType.create(subscription_type: "Customer")
    zip_code = ZipCode.create(zip_code: 80602)
    @condition1 = Condition.create(date: "2013-8-29", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
    @condition2 = Condition.create(date: "2014-10-29", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
    @trip1 = Trip.create(duration: 100, start_date: "29/8/2013 14:14", start_station_id: @station1.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike1.id, subscription_type_id: subscription_type1.id, zip_code_id: zip_code.id, condition: @condition1)
    @trip2 = Trip.create(duration: 200, start_date: "29/8/2013 14:14", start_station_id: @station1.id, end_date: "29/8/2013 20:14", end_station_id: @station1.id, bike_id: @bike2.id, subscription_type_id: subscription_type2.id, zip_code_id: zip_code.id, condition: @condition1)
    @trip3 = Trip.create(duration: 300, start_date: "29/10/2014 14:14", start_station_id: @station2.id, end_date: "29/8/2013 20:14", end_station_id: @station2.id, bike_id: @bike2.id, subscription_type_id: subscription_type2.id, zip_code_id: zip_code.id, condition: @condition2)
  end

  describe ".average_duration" do
    it "returns average trip duration" do
      expect( Trip.average_duration ).to eq(3)
    end
  end

  describe ".longest_ride" do
    it "returns longest duration of a ride" do
      expect(Trip.longest_ride).to eq(5)
    end
  end

  describe ".shortest_ride" do
    it "returns shortest duration of a ride" do
      expect(Trip.shortest_ride).to eq(1)
    end
  end

  describe ".start_station_with_most_rides" do
    it "returns station with most rides started from" do
      expect(Station.start_station_with_most_rides).to eq(@station1)
    end
  end

  describe ".end_station_with_most_rides" do
    it "returns station with most rides ended at" do
      expect(Station.end_station_with_most_rides).to eq(@station2)
    end
  end

  describe ".total_rides_per_month" do
    it "returns each year" do
      expect(Trip.years).to eq([2013, 2014])
    end
    it "returns total rides for every year month combo" do
      expect(Trip.year_month_total(2013, 8)).to eq(2)
      expect(Trip.year_month_total(2014, 10)).to eq(1)
    end
    it "returns year subtotals" do
      expect(Trip.year_sub_totals(2013)).to eq(2)
      expect(Trip.year_sub_totals(2014)).to eq(1)
    end
    it "returns appropriate month string" do
      expect(Trip.month_library[4]).to eq("April")
      expect(Trip.month_library[10]).to eq("October")
    end
  end

  describe ".most_ridden_bike" do
    it "finds the bike with the most trips" do
      expect(Bike.most_trips).to eq(@bike2)
    end
  end

  describe ".least_ridden_bike" do
    it "finds the bike with the least amount of trips" do
      expect(Bike.least_trips).to eq(@bike1)
    end
  end

  describe ".total_customer_subscriptions" do
    it "finds the total number of Customer Subscriptions" do
      expect(SubscriptionType.total_customers).to eq(2)
    end
  end

  describe ".total_subscriber_subscriptions" do
    it "finds the total number of Subscriber Subscriptions" do
      expect(SubscriptionType.total_subscribers).to eq(1)
    end
  end

  describe ".customer_subscriptions_percent" do
    it "finds the percentage of Customer Subscriptions" do
      expect(SubscriptionType.percent_subscription_type(SubscriptionType.total_customers)).to eq(66.67)
    end
  end

  describe ".subscriber_subscriptions_percent" do
    it "finds the percentage of Subscriber Subscriptions" do
      expect(SubscriptionType.percent_subscription_type(SubscriptionType.total_subscribers)).to eq(33.33)
    end
  end

  describe ".date_with_most_trips" do
    it "finds the single date with the most trips taken" do
      expect(Trip.date_with_most_trips).to eq(Date.parse("29/8/2013"))
    end
  end

  describe ".date_with_least_trips" do
    it "finds the single date with the least trips taken" do
      expect(Trip.date_with_least_trips).to eq(Date.parse("29/10/2014"))
    end
  end

end
