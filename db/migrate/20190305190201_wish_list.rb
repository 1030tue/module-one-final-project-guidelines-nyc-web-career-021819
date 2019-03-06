class WishList < ActiveRecord::Migration[5.0]
  def change
    create_table :wishes do |t|
      t.integer :user_id
      t.integer :drink_id
      t.string :drink_name
    end
  end
end
