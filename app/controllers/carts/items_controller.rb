module Carts
  class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]
    before_action :set_items_and_discounts, only: [:index, :create, :update]

    def create
      @item = Item.new(product: Product.find(item_params[:product_id]))
      @item.quantity = quantity
      if @item.save
        render json: items_and_discounts_serialized, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end

    def update
      if @item.update(quantity: item_params[:quantity])
        decide_whether_destroy
        render json: items_and_discounts_serialized
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @item.destroy
    end

    private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.permit(:quantity, :product_id, :id)
    end

    def quantity
      # params.has_key? :quantity ? item_params[:quantity] : 1
      if params.has_key? :quantity
        item_params[:quantity]
      else
        1
      end
    end

    def decide_whether_destroy
      if item_params[:quantity].zero?
        destroy
      end
    end
  end
end

