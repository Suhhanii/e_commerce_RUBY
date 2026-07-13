class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render plain: "Record Not Found (Prodcut Controller)", status: 404
  end

  allow_unauthenticated_access only: %i[index show]

  before_action :set_product, only: %i[show edit update destroy]

  def divide
    a=params[:a].to_i
    b=params[:b].to_i
    a/b
  end

  def index
    @products = Product.all # rails use instance variable to share data to view
  end

  def show
    # @product = Product.find(params[:id])
  session[:visited_products] ||= 0
  session[:visited_products] += 1
  end

  def new
    #return a new blank obj to fronend to get data from form field and put it in product obj
    @product = Product.new
  end

  private def product_params
     params.expect(product: [:name, :description,:featured_image ])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      cookies[:product_name] = @product.name
      redirect_to "/products/#{@product.id}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @product = Product.find(params[:id])
  end

  def update
    # @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to "/products/#{@product.id}"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end
end
