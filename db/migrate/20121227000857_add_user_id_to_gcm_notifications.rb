class AddUserIdToGcmNotifications < ActiveRecord::Migration
  def change
    add_column :gcm_notifications, :user_id, :int
  end
end
