![Build Status](https://codeship.com/projects/f7dd2ab0-76c9-0134-78ea-72db67b0714c/status?branch=master)
![Code Climate](https://codeclimate.com/github/Pete-Eichman/Breakable-Toy.png)
![Coverage Status](https://coveralls.io/repos/Pete-Eichman/Breakable-Toy/badge.png)

# Park-Me!
Park-Me was written using the following:

## Back End
* Ruby -v 2.3.1
* Rails -v 5.0.0.1
* PostgreSQL -v 0.15
* Google Maps API
* Google Geocoder API
* Twilio API via twilio-ruby gem -v 4.11.1

## Front End
* Materialize SCSS via materialize-sass gem

## Testing
* Rspec-rails gem
* Capybara & Capybara-webkit gems
* Factory Girl

## Other included gems
* Geokit-rails to validate Parking Pass model
* Devise gem for user authentication
* Omniauth-facebook gem for user authentication
* JQuery-Rails


# Get Set Up
* Clone down the repository.
* Run 'bundle install' or 'bundle exec bundle install' to download the Gemfile.
* Run the following commands to setup the database:
  * 'rake db:create'
  * 'rake db:migrate'
  * 'rake db:seed'
* Run 'rake' or 'rspec' to start the test suite.
* Run 'rails s' to start the server, and CTRL+C to stop the server.
* Visit localhost:3000 while the server is running.
