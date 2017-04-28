# Bike Share

![Alt text](./app/public/assets/welcome.png?raw=true "Entrance")

## Overview

* The goal of this project was to use Ruby, Sinatra, and Activerecord to build a site that analyzes bike share usage in San Francisco.

This application collects data in two ways: 1) through web forms allowing users to enter trip/station/weather information, and 2) by consuming CSV files with historical information for stations, trips, and weather. In addition to creating and storing this information for viewing at a later date, this application provides a number of user dashboards with higher level analysis of trends in bike share usage.

* This project was completed as part of the curriculum at the [Turing School of Software & Design](http://turing.io).

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `git clone https://github.com/bschwartz10/bike-share`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `bundle exec rake db:{create,migrate,seed}` to set up the postgres database and seed it with categories and powers.
  5. Run the application in the dev environment by running `shotgun`
  6. Visit `http://localhost:9393/`

## Learning Goals

### ActiveRecord

* Use ActiveRecord migrations to create a normalized database
* Use intermediate ActiveRecord queries to calculate and report on information in the database
* Utilize ActiveRecord methods and relationships to efficiently query the database

### User Experience and Conventions

* Use Sinatra and ERB templates to render views to create, read, update, and delete resources using restful routes and appropriate HTTP verbs
* Use Sinatra and ERB templates to display a dashboard not related to a specific resource saved in the database
* Use HTML and CSS to create a user experience that allows users to comfortably navigate a site

### Code Organization/Quality

* Organize code using best practices (use POROs when appropriate, avoid long methods, etc.)
* Create methods using ActiveRecord on the appropriate class.

### Testing

* Use RSpec to drive development at the feature and model levels.

### Working Collaboratively

* Use Git and GitHub to work collaboratively, develop in smaller groups, and resolve merge conflicts

### Features (links are to local server)
Our e-commerce platform sells hypothetical superpowers.

#### Stations
Visitors of the site can [browse bike stations](http://127.0.0.1:9393/stations) to view their address, dock count and installation date. Visitors can [edit](http://127.0.0.1:9393/stations/51/edit) a specific station's info. Visitors can delete a station. Visitors can [create](http://127.0.0.1:9393/stations/new) a new bike station by filling in the required credentials. Lastly, visitors can view the [station dashboard](http://127.0.0.1:9393/station-dashboard) page to view statistics about San Francisco bike stations.

#### Trips
Visitors of the site can [browse bike trips](http://127.0.0.1:9393/trips) to view their duration, start/end date, start/end station, bike id, subscription type and zip code. Visitors can [edit](http://127.0.0.1:9393/trips/3318/edit) a specific trip's info. Visitors can delete a station. Visitors can [create](http://127.0.0.1:9393/trips/new) a new trip by filling in the required credentials. Lastly, visitors can view the [trip dashboard](http://127.0.0.1:9393/trip-dashboard) page to view statistics about San Francisco bike trips.

#### Weather Conditions
Visitors of the site can [browse weather conditions](http://127.0.0.1:9393/conditions) to view their max/min/avg temperature, avg humidity, avg visibility, avg wind speed and precipitation. Visitors can delete a condition. Visitors can [create](http://127.0.0.1:9393/conditions/new) a new condition by filling in the required credentials. Lastly, visitors can view the [weather condition dashboard](http://127.0.0.1:9393/weather-dashboard) page to view statistics about San Francisco bike trips weather condition.

### Design
We used [Bootstrap](http://getbootstrap.com/) to style our website.

### Test Suite

The test suite tests the application on multiple levels. To run all of the tests, run `rspec` from the terminal in the main directory of the project. The feature tests (integration tests) rely mainly on the [capybara gem](https://github.com/jnicklas/capybara) for navigating the various application views.

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.

### Project Links
[Bike Share Github URL](https://github.com/bschwartz10/bike-share)

[Bike Share Project Spec](https://github.com/turingschool/bike-share)

### Contributors:
* [Brett Schwartz](https://github.com/bschwartz10/little_shop_of_orders)
* [Victoria Vasys](https://github.com/VictoriaVasys)
* [Danny Radden](https://github.com/dannyradden)
* [Lauren Oliveri](https://github.com/lao9)
