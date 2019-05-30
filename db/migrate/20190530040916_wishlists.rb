class Wishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|
      t.string :name
      t.integer :private
      t.integer :bought
      t.integer :user_id
    end
  end
end
