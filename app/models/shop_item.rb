class ShopItem < ActiveRecord::Base
  attr_accessible :flat_id, :name, :paid_back, :price, :user_bought_id, :user_want_id, :updated_at

  validates :flat_id, :name, :user_want_id, :presence => true

  belongs_to :flat

  def send_out
  	recipient_ids = 
  		User.joins(:gcm_device).where(:flat_id => current_user.flat_id).map{ |u| u.gcm_device.registration_id }
    notification = member.gcm_device.notifications.build(
      :data => {
        :registration_ids => recipient_ids,
        :item => self.name,
        :user_want_id => self.user_want_id
        },
      :collapse_key => "New shopping")
    notification.save
 		Gcm::Notification.send_notifications
  end
end
