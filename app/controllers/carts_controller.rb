class CartsController < ApplicationController
  before_action :set_items_and_discounts, only: [:show]

  def show
    render json: items_and_discounts_serialized
  end
end
