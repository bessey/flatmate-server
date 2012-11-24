class User < ActiveRecord::Base
  attr_accessible :first_name, :flat_id, :geocode_lat, :geocode_long, :last_name, :phone_number
end
