module Carts
  class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]
    before_action :set_cart, only: [:create, :update]
    # GET /items
    def index
      @items = Item.all
      render json: @items
    end

    # GET /items/1
    def show
      render json: @item
    end

    # POST /items
    def create
      @item = Item.new(product: Product.find(item_params[:product_id]),
                       cart: @cart)
      @item.quantity = quantity
      if @item.save
        render json: @cart, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /items/1
    def update
      if @item.update(quantity: item_params[:quantity])
        render json: @cart
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end

    # DELETE /items/1
    def destroy
      @item.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.permit(:quantity, :product_id, :id)
    end

    def set_cart
      if(Cart.first.nil?)
        Cart.create
      end
      @cart = Cart.first
    end

    def quantity
      if params.has_key? :quantity
        params[:quantity]
      else
        1
      end
    end
  end
end

