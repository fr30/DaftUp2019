class Item < ApplicationRecord
  validates :product_id, :uniqueness => { :scope => [:cart_id] }
  belongs_to :cart
  belongs_to :product
end
