class Api::V1::PricesController < Api::V1::ApiController
  # Rota para todos os preços de um determinado plano que
  # esteja ativo
  #
  # = Exemplo de Request
  #   GET /api/v1/plans/:plan_id/prices
  #
  # = Exemplo de Response
  #   => Status Code: 200 OK
  # [
  #   {
  #   "id": 1,
  #   "plan_price": "315.6",
  #   "plan_id": 2,
  #   "periodicity_id": 4,
  #   "created_at": "2021-03-13T20:18:19.746Z",
  #   "updated_at": "2021-03-13T20:18:19.746Z"
  #   },
  #   {
  #   "id": 2,
  #   "plan_price": "86.1",
  #   "plan_id": 2,
  #   "periodicity_id": 2,
  #   "created_at": "2021-03-13T20:18:19.808Z",
  #   "updated_at": "2021-03-13T20:18:19.808Z"
  #   }
  # ]
  def index
    plan = Plan.activated.find_by(id: find_plan.fetch(:plan_id))
    
    if plan.present?
      render json: plan.prices, status: :ok
    else
      render body: nil, status: :not_found
    end
  end

  private

  def find_plan
    params.permit(:plan_id)
  end
end
