class Api::V1::PlansController < Api::V1::ApiController
  def index
    render json: Plan.all
  end

  def show
    @plan = Plan.find(params[:id])
    render json: @plan, status: :ok
  end

  def product_type
    @plans = Plan.where(product_type: params[:product_type_id])
    render json: @plans, status: :ok
  end
end
