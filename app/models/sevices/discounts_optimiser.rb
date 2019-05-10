class DiscountsOptimiser < ApplicationRecord
  def call
    promos = Discount.all
  end

  def calc_diff promo

  end

end
