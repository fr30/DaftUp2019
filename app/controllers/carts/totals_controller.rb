module Carts
  class TotalsController < ApplicationController
    before_action :set_cart, only: [:show]

    # GET /totals
    # def index
    #   @totals = Total.all
    #
    #   render json: @totals
    # end

    # GET /totals/1
    def show
      render json: @cart
    end

    # # POST /totals
    # def create
    #   @total = Total.new(total_params)
    #
    #   if @total.save
    #     render json: @total, status: :created, location: @total
    #   else
    #     render json: @total.errors, status: :unprocessable_entity
    #   end
    # end
    #
    # # PATCH/PUT /totals/1
    # def update
    #   if @total.update(total_params)
    #     render json: @total
    #   else
    #     render json: @total.errors, status: :unprocessable_entity
    #   end
    # end
    #
    # # DELETE /totals/1
    # def destroy
    #   @total.destroy
    # end
    #
    private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_total
    #   @total = Total.find(params[:id])
    # end
    #
    # # Only allow a trusted parameter "white list" through.
    # def total_params
    #   params.fetch(:total, {})
    # end
    def set_cart
      if(Cart.first.nil?)
        Cart.create
      end
      @cart = Cart.first
    end
  end
end

