module Carts
  class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]
    before_action :set_cart, only: [:crate]
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
                       cart: Cart.first,
                       quantity: item_params[:quantity])
      # render json: item_params
      if @item.save
        render json: Cart.first.products, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /items/1
    def update
      if @item.update(item_params)
        render json: @item
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
      params.permit(:quantity, :product_id)
    end

    def set_cart
      if(Cart.first.nil?)
        Cart.create
      end
    end
  end
end

