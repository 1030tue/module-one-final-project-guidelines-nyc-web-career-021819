class CreateRating < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :drink_id
      t.float :rating
      t.string :comment
    end
  end
end
