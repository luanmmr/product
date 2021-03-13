class Api::V1::ProductTypesController < Api::V1::ApiController
  def index
    render json: ProductType.all
  end

  def show
    @product = ProductType.find(params[:id])
    render json: @product, status: :ok
  end
end
