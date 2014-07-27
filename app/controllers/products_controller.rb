class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy], except: [:update_all]

  def index
    # if params[:min].nil? || params[:max].nil?
    #   @products = Product.all
    # else
    #   min, max = params[:min].to_i, params[:max].to_i
    #   @products = Product.where(price: min..max)
    # end
    @products = Product.all
    @products = @products.where('price >= ?', params[:min]) if params[:min].present?
    @products = @products.where('price <= ?', params[:max]) if params[:max].present?
    xsc = (params[:desc].present? ? :desc : :asc)
    @products = @products.order(params[:order] => xsc) if params[:order].present?

    per_page = 10
    page = params[:p].to_i - 1
    offset = page * per_page
    @products = @products.limit(per_page).offset(offset)
    @max_page = Product.count / per_page + 1
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

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

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_all
    @p = Product.find(params[:ids])
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :name_confirmation, :desc, :price, :category_id)
    end
end
