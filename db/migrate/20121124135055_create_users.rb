class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :flat_id
      t.float :geocode_lat
      t.float :geocode_long
      t.string :phone_number

      t.timestamps
    end
  end
end
