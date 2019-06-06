class ProductsController < ApplicationController
  def index
    render json: products
  end

  private

  def products
    Product.all
  end

end
