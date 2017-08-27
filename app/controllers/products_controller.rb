class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  include ChartBuilder

  # GET /products
  # GET /products.json
  def index
    @products = Product.includes(:shop)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @prices = @product.prices
    @min_price = @prices.select("id, min(value) as min_price_value, created_at as time")
                        .group(:id, :created_at)
                        .order("min_price_value asc")
                        .first
    @size, @data = ChartBuilder.call(@prices)
  end

  # GET /products/new
  def new
    @product = Product.new
    @shops = Shop.pluck(:name, :id)
  end

  # GET /products/1/edit
  def edit
    @shops = Shop.pluck(:name, :id)
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :href, :shop_id, :price_xpath)
    end
end
