#DRY inventor: *cries*
class DiscountSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :id, if: :id_condition?
  attribute :kind, if: :kind_condition?
  attribute :products, if: :products_condition?
  attribute :count, if: :count_condition?
  attribute :price, if: :price_condition?
  attribute :total, if: :total_condition?
  attribute :product_ids, if: :product_ids_condition?

  def product_ids_condition?
    true if type == :discount
  end

  def total
    object.price
  end

  def total_condition?
    true if type == :set
  end

  def products
    object.product_ids.map do |product_id|
      ProductSerializer.new(Product.find(product_id))
    end
  end

  def products_condition?
    true if type == :set
  end

  def kind_condition?
    true if type == :discount
  end

  def id_condition?
    true if type == :discount
  end

  def count_condition?
    if type == :discount
      object.kind == 'extra'
    else
      false
    end
  end

  def price_condition?
    if type == :discount
      object.kind == 'set'
    else
      false
    end
  end

  def type
    @instance_options[:type]
  end

end
