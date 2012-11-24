class Flat < ActiveRecord::Base
  attr_accessible :description, :geocode_lat, :geocode_long, :nickname, :postcode
end
