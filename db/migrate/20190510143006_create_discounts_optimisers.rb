class CreateDiscountsOptimisers < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts_optimisers do |t|

      t.timestamps
    end
  end
end
