class AddColourIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :colour_id, :integer
  end
end
