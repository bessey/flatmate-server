class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :nickname
      t.string :postcode
      t.text :description
      t.float :geocode_lat
      t.float :geocode_long

      t.timestamps
    end
  end
end
