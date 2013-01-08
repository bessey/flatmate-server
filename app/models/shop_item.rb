class ShopItem < ActiveRecord::Base
  attr_accessible :flat_id, :name, :paid_back, :price, :user_bought_id, :user_want_id, :updated_at

  validates :flat_id, :name, :user_want_id, :presence => true

  belongs_to :flat

  default_scope order("updated_at DESC").where('paid_back == false or paid_back IS NULL')

  def send_out(sender)
  	recipient_ids = 
  		User.joins(:gcm_device).where(:flat_id => sender.flat_id).map{ |u| u.gcm_device.registration_id }
    if sender.gcm_device
      notification = sender.gcm_device.notifications.build()
      notification.data = {
          :registration_ids => recipient_ids,
          :data => {
            :item => self.name,
            :user_want_id => self.user_want_id,
            :user_bought_id => self.user_bought_id,
            :price => self.price,
            :paid_back => self.paid_back,
            :id => self.id
          }
        }
      notification.collapse_key = "New shopping"
      notification.save
   		Gcm::Notification.send_notifications
    end
  end

  def self.test(sender)
    s = ShopItem.new(
          :name => "Zaffa Cakes",
          :user_want_id => sender.id,
          )
    s.save
    s.send_out(sender)
  end


end
