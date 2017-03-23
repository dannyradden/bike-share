require 'time'
require 'date'

class Station < ActiveRecord::Base
  belongs_to :city

  has_many :start_trips, class_name: 'Trip', foreign_key: :start_station_id
  has_many :end_trips, class_name: 'Trip', foreign_key: :end_station_id

  validates :name, presence: true, uniqueness: true
  validates :dock_count, presence: true
  validates :city_id, presence: true
  validates :installation_date, presence: true

  default_scope { order(:name) }

  def self.total_stations
    Station.count
  end

  def self.average_bikes
    Station.average(:dock_count).to_i
  end

  def self.most_bikes
    Station.maximum(:dock_count)
  end

  def self.list_maker(list)
    if list.count == 0
      if list.first.class == Station
        "No Stations Availible"
      elsif list.first.class == ZipCode
        "No Zip Codes Availible"
      elsif list.first.class == Bike
        "No Bikes Availible"
      else
        "No Dates Availible"
      end
    elsif list.count == 1
      if list.first.class == Station
        list.first.name
      elsif list.first.class == ZipCode
        list.first.zip_code.to_s
      elsif list.first.class == Bike
        list.first.bike_number.to_s
      else
        list.first.strftime("%B %d, %Y")
      end
    else
      if list.first.class == Station
        output = list.reduce("") do |sum, station|
            sum + station.name + ", "
        end
      elsif list.first.class == ZipCode
        output = list.reduce("") do |sum, zipcode|
            sum + zipcode.zip_code.to_s + ", "
        end
      elsif list.first.class == Bike
        output = list.reduce("") do |sum, bike|
            sum + bike.bike_number.to_s + ", "
        end
      else
        output = list.reduce("") do |sum, date|
            sum + date.strftime("%B %d, %Y") + ", "
        end
      end
      output[0..-3]
    end
  end

  def self.stations_with_most_bikes
    list_maker(Station.where(dock_count: most_bikes))
  end

  def self.fewest_bikes
    Station.minimum(:dock_count)
  end

  def self.stations_with_fewest_bikes
    list_maker(Station.where(dock_count: fewest_bikes))
  end

  def self.newest_installation_date
    Station.maximum(:installation_date)
  end

  def self.newest_stations
    list_maker(Station.where(installation_date: newest_installation_date))
  end

  def self.oldest_installation_date
    Station.minimum(:installation_date)
  end

  def self.oldest_stations
    list_maker(Station.where(installation_date: oldest_installation_date))
  end

  def self.create_station(params)
    Station.create(
      name: params[:station][:name],
      dock_count: params[:station][:dock_count],
      city: City.find_or_create_by(name: params[:station][:city]),
      installation_date: params[:station][:installation_date]
    )
  end

  def self.update_station(params)
    Station.find(params[:id]).update(
      name: params[:station][:name],
      dock_count: params[:station][:dock_count],
      city: City.find_or_create_by(name: params[:station][:city]),
      installation_date: params[:station][:installation_date]
    )
  end

  def self.start_station_with_most_rides
    Station.all.max_by {|station| station.start_trips.count}
  end

  def self.end_station_with_most_rides
    Station.all.max_by {|station| station.end_trips.count}
  end

  def number_of_rides_started
    start_trips.count
  end

  def number_of_rides_ended
    end_trips.count
  end

  def most_frequent_destination
    freq = start_trips.pluck(:end_station_id).inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    max = freq.values.max
    stations = freq.select { |k, f| f == max }.keys.map{|id| Station.find(id)}
    Station.list_maker(stations)
  end

  def most_frequent_origin
    freq = end_trips.pluck(:start_station_id).inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    max = freq.values.max
    stations = freq.select { |k, f| f == max }.keys.map{|id| Station.find(id)}
    Station.list_maker(stations)
  end

  def busiest_days
    dates = start_trips.map {|trip| trip.start_date.to_date}
    freq = dates.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    max = freq.values.max
    date = freq.select { |k, f| f == max }.keys
    Station.list_maker(date) + " with #{max} trips"
  end

  def most_frequent_zip_codes
    freq = start_trips.pluck(:zip_code_id).inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    max = freq.values.max
    zip_codes = freq.select { |k, f| f == max }.keys.map{|id| ZipCode.find(id)}
    Station.list_maker(zip_codes) + " with #{max} trips"
  end

  def most_frequent_bike
    freq = start_trips.pluck(:bike_id).inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    max = freq.values.max
    bikes = freq.select { |k, f| f == max }.keys.map{|id| Bike.find(id)}
    Station.list_maker(bikes) + " with #{max} trips"
  end

end
