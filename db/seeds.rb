require 'csv'
require './app/models/station'
require './app/models/city'
require './app/models/bike'
require './app/models/subscription_type'
require './app/models/trip'
require './app/models/zip_code'
require './app/models/condition'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

@count = 0

def clean_station(name)
  if Station.find_by(name: name) != nil
    Station.find_by(name: name)
  else
    if name == 'Washington at Kearney'
      Station.find_by(name: 'Washington at Kearny')
    elsif name == 'Post at Kearney'
      Station.find_by(name: 'Post at Kearny')
    elsif name == 'Broadway at Main'
      Station.find_by(name: 'Stanford in Redwood City')
    elsif name == 'San Jose Government Center'
      Station.find_by(name: 'Santa Clara County Civic Center')
    end
  end
end

def clean_zipcode(zip_code)
  return nil if zip_code.nil? || zip_code.length < 3
  zip_code = zip_code[0..4]
  ZipCode.find_or_create_by(zip_code: zip_code)
end

def clean_datetime(datetime)
  dt = datetime.split('/')
  dt[0], dt[1] = dt[1], dt[0]
  dt.join('/')
end

CSV.foreach "db/csv/station.csv", headers: true, header_converters: :symbol do |row|
  Station.create(
    name:               row[:name],
    dock_count:         row[:dock_count],
    city:               City.find_or_create_by(name: row[:city]),
    installation_date:  clean_datetime(row[:installation_date])
  )
  p "Creating Station #{row[:name]} "
end

CSV.foreach "db/csv/weather.csv", headers: true, header_converters: :symbol do |row|
  if row[:zip_code] == '94107'
    Condition.create(
      date:               clean_datetime(row[:date]),
      max_temp:           row[:max_temperature_f],
      mean_temp:          row[:mean_temperature_f],
      min_temp:           row[:min_temperature_f],
      mean_humidity:      row[:mean_humidity],
      mean_visibility:    row[:mean_visibility_miles],
      mean_wind_speed:    row[:mean_wind_speed_mph],
      precipitation:      row[:precipitation_inches]
    )
    p "Creating Condition on date #{clean_datetime(row[:date])} "
  end
end

CSV.foreach "db/csv/trip.csv", headers: true, header_converters: :symbol do |row|
  @count += 1
  Trip.create(
    duration:             row[:duration],
    start_date:           clean_datetime(row[:start_date]),
    start_station:        clean_station(row[:start_station_name]),
    end_date:             clean_datetime(row[:end_date]),
    end_station:          clean_station(row[:end_station_name]),
    bike:                 Bike.find_or_create_by(bike_number: row[:bike_id]),
    zip_code:             clean_zipcode(row[:zip_code]),
    subscription_type:    SubscriptionType.find_or_create_by(subscription_type: row[:subscription_type]),
    condition:            Condition.find_by(date: clean_datetime(row[:start_date]).to_date)
  )
  p "Creating Trip Number #{@count} with start station #{row[:start_station_name]} "
end
