class WishList < ActiveRecord::Migration[5.0]
  def change
    create_table :wishes do |t|
      t.integer :user_id
      t.integer :drink_id
    end
  end
end
