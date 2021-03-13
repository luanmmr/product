class Api::V1::PricesController < Api::V1::ApiController
  def index
    @prices = Plan.activated.find(params[:plan_id]).prices
    render json: @prices, status: :ok
  end
end
