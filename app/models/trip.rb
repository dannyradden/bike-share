class Trip < ActiveRecord::Base
 belongs_to :start_station, class_name: 'Station', foreign_key: :start_station_id
 belongs_to :end_station, class_name: 'Station', foreign_key: :end_station_id

 belongs_to :bike
 belongs_to :zip_code
 belongs_to :subscription_type

 belongs_to :condition

 validates :start_date, presence: true
 validates :start_station_id, presence: true
 validates :end_date, presence: true
 validates :end_station_id, presence: true
 validates :bike_id, presence: true
 validates :subscription_type_id, presence: true

 def self.create_trip(params)
   Trip.create!(
     duration:             (Time.parse(params[:trip][:end_date]) - Time.parse(params[:trip][:start_date])).to_i,
     start_date:           params[:trip][:start_date],
     start_station_id:     params[:trip][:start_station],
     end_date:             params[:trip][:end_date],
     end_station_id:       params[:trip][:end_station],
     subscription_type_id: params[:trip][:subscription_type],
     zip_code:             ZipCode.find_or_create_by(zip_code: params[:trip][:zip_code]),
     bike:                 Bike.find_or_create_by(bike_number: params[:trip][:bike_number]),
     condition:            Condition.find_by(date: params[:trip][:start_date].to_date)
   )
 end

 def self.update_trip(params)
   Trip.find(params[:id]).update(
     duration:             (Time.parse(params[:trip][:end_date]) - Time.parse(params[:trip][:start_date])).to_i,
     start_date:           params[:trip][:start_date],
     start_station_id:     params[:trip][:start_station],
     end_date:             params[:trip][:end_date],
     end_station_id:       params[:trip][:end_station],
     subscription_type_id: params[:trip][:subscription_type],
     zip_code:             ZipCode.find_or_create_by(zip_code: params[:trip][:zip_code]),
     bike:                 Bike.find_or_create_by(bike_number: params[:trip][:bike_number]),
     condition:            Condition.find_by(date: params[:trip][:start_date].to_date)
   )
 end

 def self.average_duration
   Trip.average(:duration).to_i
 end

 def self.longest_ride
   Trip.maximum(:duration).to_i
 end

 def self.shortest_ride
   Trip.minimum(:duration).to_i
 end

  def self.trip_quantities
    date = Trip.all.map {|trip| trip.start_date.to_date}
    date.reduce(Hash.new(0)) {|h, date| h[date] += 1; h}
  end

  def self.date_with_most_trips
    Trip.trip_quantities.max_by {|key, value| value}.first
  end

  def self.date_with_least_trips
    Trip.trip_quantities.min_by {|key, value| value}.first
  end

  def self.years
    Trip.pluck(:start_date).map(&:year).uniq.sort
  end

  def self.year_month_total(year, month)
    Trip.where('extract(year from start_date) = ? and extract(month from start_date) = ?', year, month).count
  end

  def self.year_sub_totals(year)
    Trip.where('extract(year from start_date) = ?', year).count
  end

  def self.month_library
    {
      1 => "January",
      2 => "February",
      3 => "March",
      4 => "April",
      5 => "May",
      6 => "June",
      7 => "July",
      8 => "August",
      9 => "September",
      10 => "October",
      11 => "November",
      12 => "December"
    }
  end
  
  def self.weather_on_day_with_highest_rides
    Condition.find_by(date: Trip.date_with_most_trips)
  end
  
  def self.weather_on_day_with_least_rides
    Condition.find_by(date: Trip.date_with_least_trips)
  end

end
