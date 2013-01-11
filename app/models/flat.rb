class Flat < ActiveRecord::Base
  attr_accessible :description, :geocode_lat, :geocode_long, :nickname, :postcode
  has_many :users
  has_many :messages
  has_many :shop_items
  before_save :sanitise_postcode
  validates :nickname, :postcode, :presence => true

  def sanitise pc
      pc.gsub(/[^0-9a-z]/i, '').upcase 
  end

  def sanitise_postcode
  	self.postcode = sanitise(self.postcode)
  end

end
