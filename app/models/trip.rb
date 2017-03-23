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
   average_duration = Trip.average(:duration).to_i
   average_duration / 60
 end

 def self.longest_ride
   longest_ride = Trip.maximum(:duration).to_i
   longest_ride / 60
 end

 def self.shortest_ride
   shortest_ride = Trip.minimum(:duration).to_i
   shortest_ride / 60
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

  # LAUREN WILL REFACTOR THE BELOW DISGUSTINGNESS :D

  def self.total_rides_per_month
    ride_months = Trip.all.reduce(Hash.new(0)) do |hash, trip|
      hash[trip.start_date.month] = Hash.new(0)
      hash
    end

    Trip.all.each do |trip|
      ride_months[trip.start_date.month][trip.start_date.year] +=1
    end

    ride_months
  end

  def self.rides_per_month_prepper
    Trip.total_rides_per_month.values.map {|h| h.keys }.flatten.uniq.sort
  end

  def self.top_table_row
    years = Trip.rides_per_month_prepper
    years.reduce("") do |sum, year|
      sum + "<th>#{year}</th>"
    end
  end

  def self.month_rows
    years = Trip.rides_per_month_prepper
    month_hash = Trip.total_rides_per_month
    grand_total_hash = Hash.new(0)
    sum = ""
    12.times do |month|
      sum += ("<tr>" + "<td>" + Trip.month_library[month+1] + "</td>")
      years.each do |year|
        thing = month_hash[month+1][year]
        sum += ("<td>" + "#{thing}" + "</td>")
        grand_total_hash[year] += thing
      end
    end
    sum += "</tr>"
    [sum, grand_total_hash]
  end

  def self.grand_total_rows
    years = Trip.rides_per_month_prepper
    grand_total_hash = Trip.month_rows[1]
    sum = ""
    years.each do |year|
      sum += "<td>#{grand_total_hash[year]}</td>"
    end
    sum
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

end
