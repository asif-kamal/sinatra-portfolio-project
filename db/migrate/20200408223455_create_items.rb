class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :quantity
      t.integer :shoppinglist_id
    end
  end
end
