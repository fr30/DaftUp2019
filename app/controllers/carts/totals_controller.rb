module Carts
  class TotalsController < ApplicationController
    before_action :set_items_and_discounts, only: [:show]

    def show
      render json: DiscountsOptimiser.new.call
    end

  end
end

