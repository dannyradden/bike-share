require 'will_paginate/active_record'

class BikeShareApp < Sinatra::Base
  include WillPaginate::Sinatra::Helpers

  get '/' do
    erb :"home/index"
  end

  get '/stations' do
    @stations = Station.all.order(:name).paginate(page: params[:page], per_page: 30)
    erb :"stations/index"
  end

  get '/stations/new' do
    erb :"stations/new"
  end

  post '/stations' do
    @station = Station.create_station(params)
    redirect "/stations/#{@station.id}"
  end

  get '/stations/:id' do
    @station = Station.find(params[:id])
    erb :"stations/show"
  end

  get '/stations/:id/edit' do
    @station = Station.find(params[:id])
    erb :"stations/edit"
  end

  put '/stations/:id' do
    Station.update_station(params)
    redirect "/stations/#{params[:id]}"
  end

  delete '/stations/:id' do
    Station.destroy(params[:id])
    redirect '/stations'
  end  

  get '/station-dashboard' do
    @stations = Station
    erb :"stations/dashboard"
  end

  get '/trips' do
    @trips = Trip.all.order(start_date: :desc).paginate(page: params[:page], per_page: 30)
    erb :'trips/index'
  end

  post '/trips' do
    @trip = Trip.create_trip(params)
    redirect "/trips/#{@trip.id}"
  end

  get '/trips/new' do
    @stations = Station.all
    @subtypes = SubscriptionType.all
    erb :'trips/new'
  end

  get '/trips/:id' do
    @trip = Trip.find(params[:id])
    erb :'trips/show'
  end

  put '/trips/:id' do
    Trip.update_trip(params)
    redirect "/trips/#{params[:id]}"
  end

  get '/trips/:id/edit' do
    @trip = Trip.find(params[:id])
    @stations = Station.all
    @subtypes = SubscriptionType.all
    erb :'trips/edit'
  end

  delete '/trips/:id' do
    Trip.destroy(params[:id])
    redirect '/trips'
  end
  
  get '/trip-dashboard' do
    @trips = Trip
    @stations = Station
    @bikes = Bike
    @subscriptions = SubscriptionType
    erb :"trips/dashboard"
  end
  
  get '/conditions' do
    @conditions = Condition.all.order(date: :desc).paginate(page: params[:page], per_page: 30)
    erb :'conditions/index'
  end

  post '/conditions' do
    @condition = Condition.create_condition(params)
    redirect "/conditions/#{@condition.id}"
  end

  get '/conditions/new' do
    erb :'conditions/new'
  end

  get '/conditions/:id' do
    @condition = Condition.find(params[:id])
    erb :'conditions/show'
  end

  put '/conditions/:id' do
    Condition.update_condition(params)
    redirect "/conditions/#{params[:id]}"
  end

  get '/conditions/:id/edit' do
    @condition = Condition.find(params[:id])
    erb :'conditions/edit'
  end

  delete '/conditions/:id' do
    Condition.destroy(params[:id])
    redirect '/conditions'
  end
  
  get '/weather-dashboard' do
    @conditions = Condition
    erb :"conditions/dashboard"
  end

end
