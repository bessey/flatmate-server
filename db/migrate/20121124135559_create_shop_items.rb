class CreateShopItems < ActiveRecord::Migration
  def change
    create_table :shop_items do |t|
      t.integer :flat_id
      t.integer :user_want_id
      t.integer :user_bought_id
      t.decimal :price
      t.string :name
      t.boolean :paid_back

      t.timestamps
    end
  end
end
