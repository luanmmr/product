class Api::V1::PlansController < Api::V1::ApiController
  def index
    render json: Plan.all
  end

  def show
    render json: @plan, status: :ok if @plan = Plan.find(params[:id])
  end
end
