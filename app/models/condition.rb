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

end
