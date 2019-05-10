module Carts
  class DiscountsController < ApplicationController
    before_action :set_items_and_discounts, only: [:create]

    def create
      # render json: discount_params[:product_ids]
      @discount = Discount.new(discount_params)
      if @discount.save
        render json: items_and_discounts_serialized, status: :created
      else
        render json: @discount.errors, status: :unprocessable_entity
      end
    end

    def update
      if @discount.update(discount_params)
        render json: @discount
      else
        render json: @discount.errors, status: :unprocessable_entity
      end
    end

    private

    def discount_params
      params.permit(:kind, :name, :price, product_ids: [])
    end
  end
end

