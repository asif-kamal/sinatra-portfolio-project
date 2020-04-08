class CreateShoppinglist < ActiveRecord::Migration
  def change
    create_table :shoppinglist do |t|
      t.string :name_of_shopper
      t.string :num_of_items
      t.string :time_of_pickup
      t.integer :user_id
    end
  end
end
