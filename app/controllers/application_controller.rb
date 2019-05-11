class ApplicationController < ActionController::API

  protected

  def set_items_and_discounts
    @items = Item.all
    @discounts = Discount.all
  end


  def items_and_discounts_serialized
    {
        items: ActiveModel::Serializer::CollectionSerializer.new(@items),
        discounts: ActiveModel::Serializer::CollectionSerializer.new(@discounts, type: :discount)
    }
  end
end
