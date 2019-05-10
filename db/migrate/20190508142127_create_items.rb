class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :product_id
      t.integer :quantity, default: 0
      t.timestamps
      # t.index :products, :product_id
    end
  end
end
