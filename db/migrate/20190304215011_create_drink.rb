class CreateDrink < ActiveRecord::Migration[5.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.boolean :alcohol?
      t.string :liquor
    end
  end
end
