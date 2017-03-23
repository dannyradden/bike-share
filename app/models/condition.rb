class Condition < ActiveRecord::Base
  has_many :trips

  validates :date, presence: true, uniqueness: true
  validates :max_temp, presence: true
  validates :mean_temp, presence: true
  validates :min_temp, presence: true
  validates :mean_humidity, presence: true
  validates :mean_visibility, presence: true
  validates :mean_wind_speed, presence: true

    def self.create_condition(params)
      Condition.create(
        date: params[:condition][:date],
        max_temp: params[:condition][:max_temp],
        min_temp: params[:condition][:min_temp],
        mean_temp: params[:condition][:mean_temp],
        mean_humidity: params[:condition][:mean_humidity],
        mean_visibility: params[:condition][:mean_visibility],
        mean_wind_speed: params[:condition][:mean_wind_speed],
        precipitation: params[:condition][:precipitation]
      )
    end

    def self.update_condition(params)
      Condition.find(params[:id]).update(
        date: params[:condition][:date],
        max_temp: params[:condition][:max_temp],
        min_temp: params[:condition][:min_temp],
        mean_temp: params[:condition][:mean_temp],
        mean_humidity: params[:condition][:mean_humidity],
        mean_visibility: params[:condition][:mean_visibility],
        mean_wind_speed: params[:condition][:mean_wind_speed],
        precipitation: params[:condition][:precipitation]
      )
    end

    def self.average_number_of_trips_for_condition(condition, low, high)
      if Condition.condition_days(condition, low, high).count != 0
        Condition.trips_for_each_day(condition, low, high).flatten.count / Condition.condition_days(condition, low, high).count
      else
        "No days applicable"
      end
    end

      def self.trips_for_each_day(condition, low, high)
        Condition.condition_days(condition, low, high).map(&:trips)
      end

      def self.condition_days(condition, low, high)
        Condition.where(condition => low..high)
      end

    def self.most_trips_in_a_day_for_condition(condition, low, high)
      if Condition.condition_days(condition, low, high).count != 0
        Condition.trip_count_for_each_day(condition, low, high).max
      else
        "No days applicable"
      end
    end

      def self.trip_count_for_each_day(condition, low, high)
        Condition.condition_days(condition, low, high).map(&:trips.count)
      end

    def self.least_trips_in_a_day_for_condition(condition, low, high)
      if Condition.condition_days(condition, low, high).count != 0
        Condition.trip_count_for_each_day(condition, low, high).min
      else
        "No days applicable"
      end
    end


end
