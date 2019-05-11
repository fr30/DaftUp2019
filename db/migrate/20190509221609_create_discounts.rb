class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :kind
      t.string :name
      t.float :price, default: 0
      t.integer :product_ids, array: true
      t.integer :count, default: 0
      t.timestamps
    end
  end
end
