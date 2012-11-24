class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :flat_id
      t.text :contents
      t.boolean :received
      t.string :context

      t.timestamps
    end
  end
end
