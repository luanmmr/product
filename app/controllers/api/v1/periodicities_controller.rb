class Api::V1::PeriodicitiesController < Api::V1::ApiController
  # Rota para todas as periodicidades
  #
  # = Exemplo de Request
  #   GET /api/v1/periodicities
  #
  # = Exemplo de Response
  #   => Status Code: 200 OK
  # [
  #   {
  #   "id": 1,
  #   "name": "Mensal",
  #   "period": 1,
  #   "created_at": "2021-03-13T20:18:19.259Z",
  #   "updated_at": "2021-03-13T20:18:19.259Z"
  #   },
  #   {
  #   "id": 2,
  #   "name": "Trimestral",
  #   "period": 3,
  #   "created_at": "2021-03-13T20:18:19.300Z",
  #   "updated_at": "2021-03-13T20:18:19.300Z"
  #   }
  # ]
  def index
    render json: Periodicity.all, status: :ok
  end
end
