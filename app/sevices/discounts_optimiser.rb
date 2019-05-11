#hire me and I'll explain everything what happens here
class DiscountsOptimiser
  def initialize
    @regular_total = 0.0
    @regular_products = []
    @sets = []
    @extras = []
    Item.all.each do |item|
      @regular_total += item.product.price*item.quantity.to_f
    end
    set_products_and_discounts
  end

  def call #hopefully works
    promos = define_promos
    flag = true
    while flag == true
      flag = false
      temp_profit = -1.0
      winning_promo = nil
      promos.each do |promo|
        temp_output = calc_profit(promo)
        if temp_output > temp_profit
          temp_profit = temp_output
          winning_promo = promo
        end
      end
      if temp_profit >= 0
        apply_promo(winning_promo)
        flag = true
      end
    end
    set_remaining_products
    serialize_output
  end

  def set_remaining_products
    @products.each do |product_id, product_quantity|
      @regular_products.push(Product.find(product_id))
    end
  end


  def define_promos #works
    promos = Discount.where(kind: 'set').to_a
    # @sets = promos.clone
    Discount.where(kind: 'extra').each do |extra|
      extra.product_ids.each do |id|
        temp_arr = Array.new
        price = Product.find(id).price*extra.count.to_f
        for i in (0..extra.count)
          temp_arr.push(id)
        end
        new_discount = Discount.new(name: extra.name, kind: extra.kind, price: price, product_ids: temp_arr)
        promos.push(new_discount)
        # @extras.push(new_discount.clone)
      end
    end
    promos
  end

  def calc_profit promo #probably works
    profit = -promo.price
    temp_products = @products.clone
    promo.product_ids.each do |product_id|
      if delete_one(product_id: product_id, products: temp_products)
        profit += Product.find(product_id).price
      end
    end
    profit
  end

  def apply_promo promo #probably works
    if promo.kind == 'set'
      @sets.push(promo)
    else
      @extras.push(promo)
    end
    promo.product_ids.each do |product_id|
      if @products.has_key? product_id
        @products[product_id] -= 1
        if @products[product_id] == 0
          @products.delete(product_id)
        end
      end
    end
  end

  def delete_one products: products, product_id: product_id #probably works
    if !products.has_key?(product_id)
      return false
    end
    products[product_id] -= 1
    if(products[product_id].zero?)
      products.delete(product_id)
    end
    return true
  end

  def set_products_and_discounts #works
    @promos = Discount.all
    @products = Item.all.pluck(:product_id, :quantity).to_h
  end

  def serialize_output #works
    {
        sets: ActiveModel::Serializer::CollectionSerializer.new(@sets, type: :set),
        extras: ActiveModel::Serializer::CollectionSerializer.new(@extras, type: :set),
        regular_products: ActiveModel::Serializer::CollectionSerializer.new(@regular_products),
        regular_price: @regular_total
    }
  end

end
