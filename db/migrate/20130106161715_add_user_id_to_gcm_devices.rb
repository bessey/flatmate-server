class AddUserIdToGcmDevices < ActiveRecord::Migration
  def change
    add_column :gcm_devices, :user_id, :int
  end
end
