class Api::V1::ProductTypesController < Api::V1::ApiController
  def index
    render json: ProductType.all
  end

  def show
    @product = ProductType.find(params[:id])
    render json: @product, status: :ok
  end

  def plans
    @plans = Plan.where(product_type: params[:id])
    render json: @plans, status: :ok
  end
end