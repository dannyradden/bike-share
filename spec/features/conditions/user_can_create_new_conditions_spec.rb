require_relative "../../spec_helper"

RSpec.describe "When a user creates conditions for a date" do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Galvanize", dock_count: 1, installation_date: "1/4/1972")
    @bike = Bike.create(bike_number: 33)
    @subscription_type = SubscriptionType.create(subscription_type: "Subscriber")
    @zip_code = ZipCode.create(zip_code: 80602)
    @trip = Trip.create(duration: 100, start_date: "29/8/2013 14:14", start_station: @station1, end_date: "29/8/2013 20:14", end_station: @station2, bike: @bike, subscription_type: @subscription_type, zip_code: @zip_code)
  end

  it "the conditions show up in the index" do

    visit '/conditions/new'
    fill_in 'condition[date]', with: '29/7/2013'
    fill_in 'condition[max_temp]', with: 80
    fill_in 'condition[min_temp]', with: 70
    fill_in 'condition[mean_temp]', with: 75
    fill_in 'condition[mean_humidity]', with: 80
    fill_in 'condition[mean_visibility]', with: 5
    fill_in 'condition[mean_wind_speed]', with: 12
    fill_in 'condition[precipitation]', with: 0.01

    click_on 'Submit'

    expect(current_path).to eq '/conditions/1'
    expect(page).to have_content '80'
    expect(page).to have_content '12'
  end

  it "adding a trip without a condition day returns nil condition" do
      expect(Condition.find_by(date: @trip.start_date.to_date)).to eq(nil)
      expect(@trip.condition).to eq(nil)
  end

  it "creating a new condition automatically updates any existing trips" do
      visit '/conditions/new'

      visit '/conditions/new'
      fill_in 'condition[date]', with: '29/8/2013'
      fill_in 'condition[max_temp]', with: 80
      fill_in 'condition[min_temp]', with: 70
      fill_in 'condition[mean_temp]', with: 75
      fill_in 'condition[mean_humidity]', with: 80
      fill_in 'condition[mean_visibility]', with: 5
      fill_in 'condition[mean_wind_speed]', with: 12
      fill_in 'condition[precipitation]', with: 0.01

      click_on 'Submit'

      expect(Condition.find_by(date: @trip.start_date.to_date)).to eq(Condition.last)
      expect(Trip.where(:start_date => Condition.last.date.beginning_of_day..Condition.last.date.end_of_day).pluck(:condition_id).uniq).to eq([Condition.last.id])
  end

end
