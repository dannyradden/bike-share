require_relative "../../spec_helper"

RSpec.describe "When a user edits conditions" do
  it "the condition date is changed" do
    Condition.create(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)

    visit '/conditions/1/edit'
    fill_in 'condition[max_temp]', with: '36'
    click_on 'Submit'

    expect(current_path).to eq '/conditions/1'
    expect(page).to have_content 'Condition Date: March 14, 2017'
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
