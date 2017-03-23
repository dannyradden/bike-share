require_relative "../../spec_helper"

RSpec.describe "When a user visits '/conditions/:id' " do
  before :each do
    @condition1 = Condition.create(date: "14/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
    @condition2 = Condition.create(date: "15/3/2017", max_temp: 30.0, min_temp: 20.0, mean_temp: 26.0, mean_humidity: 30.0, mean_visibility: 3.0, mean_wind_speed: 12.0, precipitation: 0.03)
  end

  it "they see that condition" do
    visit '/conditions/2'

    within('h1') do
      expect(page).to have_content(@condition2.date.strftime("%B %d, %Y"))
    end
    expect(page).to have_content(@condition2.max_temp)
    expect(page).to have_content(@condition2.min_temp)
    expect(page).to have_content(@condition2.mean_temp)
    expect(page).to have_content(@condition2.mean_humidity)
    expect(page).to have_content(@condition2.mean_visibility)
    expect(page).to have_content(@condition2.mean_wind_speed)
    expect(page).to have_content(@condition2.precipitation)
  end

  it "they can click edit button" do
    visit '/conditions/2'

    click_on 'Edit'
    expect(current_path).to eq '/conditions/2/edit'
  end

  it "they can click delete button" do
    visit '/conditions/2'

    click_on 'Delete conditions for this day'
    expect(current_path).to eq '/conditions'
  end
end
