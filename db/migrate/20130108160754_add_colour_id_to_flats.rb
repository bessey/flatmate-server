class AddColourIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :colour_id, :int
  end
end
