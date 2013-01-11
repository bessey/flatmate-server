class Flat < ActiveRecord::Base
  attr_accessible :description, :geocode_lat, :geocode_long, :nickname, :postcode
  has_many :users
  has_many :messages, :dependent => :destroy
  has_many :shop_items, :dependent => :destroy
  before_save :sanitise_postcode
  validates :nickname, :postcode, :presence => true

  def sanitise pc
      pc.gsub(/[^0-9a-z]/i, '').upcase 
  end

  def send_notification sender, data, collapse_key="notification"
    recipient_ids = 
      User.joins(:gcm_device).where('flat_id = ? and users.id != ?',sender.flat_id,sender.id).map{ |u| u.gcm_device.registration_id }
    if sender.gcm_device
      notification = sender.gcm_device.notifications.build()
      notification.data = {
          :registration_ids => recipient_ids,
          :data => {
            data
          }
        }
      notification.collapse_key = collapse_key
      notification.save
      Gcm::Notification.send_notifications
    end
  end

  def sanitise_postcode
  	self.postcode = sanitise(self.postcode)
  end

end
