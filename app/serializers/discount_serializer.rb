class DiscountSerializer < ActiveModel::Serializer
  attributes :id, :kind, :name, :product_ids
end
