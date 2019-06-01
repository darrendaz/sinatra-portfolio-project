class RemoveBoughtFromWishlists < ActiveRecord::Migration[5.2]
  def change
    remove_column :wishlists, :bought, :integer
  end
end
