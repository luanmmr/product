class ProductTypesController < ApplicationController
  before_action :product_types_all, only: %i[index create]

  def index
    @product_type = ProductType.new
  end

  def create
    @product_type = ProductType.new(product_type_params)
    return redirect_back fallback_location: product_types_path,
                         notice: t('.success') if @product_type.save

    flash.now[:alert] = t('.error')
    render :index
  end

  def edit
    @product_type = ProductType.find(params[:id])
  end

  def update
    @product_type = ProductType.find(params[:id])
    return redirect_to product_types_path, notice: t('.success') \
           if @product_type.update(product_type_params)

    flash.now[:alert] = t('.error')
    render :edit
  end

  def destroy
    ProductType.destroy(params[:id])
    redirect_back fallback_location: product_types_path,
                  notice: t('.success')
  end

  private

  def product_types_all
    @product_types = ProductType.all
  end

  def product_type_params
    params.require(:product_type).permit(:name, :description, :product_key)
  end
end
