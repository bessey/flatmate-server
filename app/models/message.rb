class Message < ActiveRecord::Base
  attr_accessible :contents, :context, :flat_id, :from_id, :received, :to_id

  validates :from_id, :contents, :presence => true
  belongs_to :flat

  def send_out(sender)
    recipient_ids = 
      User.joins(:gcm_device).where(:flat_id => sender.flat_id).map{ |u| u.gcm_device.registration_id }
    if sender.gcm_device
      notification = sender.gcm_device.notifications.build()
      notification.data = {
          :registration_ids => recipient_ids,
          :message => self.contents, 
          :from_id => self.from_id,
          :flat_id => self.flat_id,
          :to_id => self.to_id,
          :context => self.context,
          :id => self.id
          }
      notification.collapse_key = "New messages"
      notification.save
      Gcm::Notification.send_notifications
    end
  end

  def self.test(sender)
    m = Message.new(
          :contents => "Hey guys, got a message for you! ",
          :flat_id => sender.flat_id,
          :from_id => sender.id,
          :context => "in",
          )
    m.save
    m.send_out(sender)
  end

end
