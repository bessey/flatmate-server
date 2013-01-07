class Message < ActiveRecord::Base
  attr_accessible :contents, :context, :flat_id, :from_id, :received, :to_id

  validates :from_id, :contents, :presence => true
  belongs_to :flat

  def send_out(flat_id)
    recipient_ids = 
      User.joins(:gcm_device).where(:flat_id => flat_id).map{ |u| u.gcm_device.registration_id }
    notification = member.gcm_device.notifications.build(
      :data => {
        :registration_ids => recipient_ids,
        :message => self.contents, 
        :from_id => self.from_id,
        :flat_id => self.flat_id,
        :to_id => self.to_id,
        :context => self.context,
        :id => self.id
        },
      :collapse_key => "New messages")
    notification.save
    Gcm::Notification.send_notifications
  end

end
