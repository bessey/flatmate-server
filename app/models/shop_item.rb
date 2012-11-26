class ShopItem < ActiveRecord::Base
  attr_accessible :flat_id, :name, :paid_back, :price, :user_bought_id, :user_want_id

  belongs_to :flat
end
