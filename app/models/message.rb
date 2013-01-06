class Message < ActiveRecord::Base
  attr_accessible :contents, :context, :flat_id, :from_id, :received, :to_id

  validates :from_id, :contents, :presence => true
  belongs_to :flat

  def send_out
  	flat_members = User.includes(:gcm_device).where(:flat_id => self.flat_id)
  	flat_members.each do |member|
  		unless member.gcm_device
  			next
  		end
  		notification = member.gcm_device.notifications.build(
  			:data => {:message => self.contents, :from_id => self.from_id},
  			:collapse_key => "new_message")
  		notification.save
  	end
 		Gcm::Notification.send_notifications
  end
end
