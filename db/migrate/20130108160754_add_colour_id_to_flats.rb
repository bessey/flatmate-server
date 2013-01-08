class AddColourIdToFlats < ActiveRecord::Migration
  def change
    add_column :flats, :colour_id, :int
  end
end
