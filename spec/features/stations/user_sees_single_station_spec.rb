require_relative "../../spec_helper"

RSpec.describe "When a user visits '/stations/:id' " do
  before :each do
    city = City.create(name: "Denver")
    @station1 = city.stations.create(name: "Turing", dock_count: 100, installation_date: "14/3/2017")
    @station2 = city.stations.create(name: "Galvanize", dock_count: 1, installation_date: "1/4/1972")
  end

  it "they see that bike station" do
    visit '/stations/2'

    within('h1') do
      expect(page).to have_content(@station2.name)
    end
    expect(page).to have_content(@station2.dock_count)
    expect(page).to have_content(@station2.city.name)
    expect(page).to have_content(@station2.installation_date.strftime("%B %d, %Y"))
  end

  it "they can click edit button" do
    visit '/stations/2'

    click_on 'Edit'
    expect(current_path).to eq '/stations/2/edit'
  end

  it "they can click delete button" do
    visit '/stations/2'

    click_on 'Delete Station'
    expect(current_path).to eq '/stations'
  end
end
