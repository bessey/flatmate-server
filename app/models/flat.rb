class Flat < ActiveRecord::Base
  attr_accessible :description, :geocode_lat, :geocode_long, :nickname, :postcode
  has_many :users
  has_many :messages
  has_many :shop_items
end
