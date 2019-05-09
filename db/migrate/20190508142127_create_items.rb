class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :quantity, default: 0
      t.index [:cart_id, :product_id], unique: true
      t.timestamps
    end
  end
end
