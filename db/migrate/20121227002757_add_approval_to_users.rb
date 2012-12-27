class AddApprovalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :flat_approved, :boolean
  end
end
