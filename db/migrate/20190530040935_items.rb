class Items < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :url
      t.integer :quantity
      t.integer :wishlist_id
    end
  end
end
