class ShopItem < ActiveRecord::Base
  attr_accessible :flat_id, :name, :paid_back, :price, :user_bought_id, :user_want_id

  validates :flat_id, :name, :user_want_id, :presence => true

  belongs_to :flat
end
