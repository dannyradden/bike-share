require_relative "../../spec_helper"

RSpec.describe "When a user edits conditions" do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Galvanize", dock_count: 1, installation_date: "1/4/1972")
    @bike = Bike.create(bike_number: 33)
    @subscription_type = SubscriptionType.create(subscription_type: "Subscriber")
    @zip_code = ZipCode.create(zip_code: 80602)
    @trip = Trip.create(duration: 100, start_date: "14/3/2017 14:14", start_station: @station1, end_date: "14/3/2017 20:14", end_station: @station2, bike: @bike, subscription_type: @subscription_type, zip_code: @zip_code, condition: @condition1)
    @condition1 = Condition.create(date: "15/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
  end
  it "the condition date is changed" do
    #Condition.create(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)

    visit '/conditions/1/edit'
    fill_in 'condition[max_temp]', with: '36'
    click_on 'Submit'

    expect(current_path).to eq '/conditions/1'
    expect(page).to have_content 'Condition Date: March 15, 2017'
    expect(page).to have_content 'Maximum Temperature: 36'
    expect(page).to_not have_content 'Maximum Temperature: 30'
    expect(page).to have_content 'Minimum Temperature: 20'
    expect(page).to have_content 'Average Temperature: 26'
    expect(page).to have_content 'Average Humidity: 30'
    expect(page).to have_content 'Average Visibility: 3'
    expect(page).to have_content 'Average Wind Speed: 12'
    expect(page).to have_content 'Precipitation: 0.03'
  end
end
