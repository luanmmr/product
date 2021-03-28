class Api::V1::PlansController < Api::V1::ApiController
  # Rota para todas os planos
  #
  # = Exemplo de Request
  #   GET /api/v1/plans
  #
  # = Exemplo de Response
  #   => Status Code: 200 OK
  # [
  #   {
  #   "id": 2,
  #   "name": "Initial",
  #   "description": "25 caixas postais, 15 GB por caixa A partir de R$ 1,05 por caixa.",
  #   "product_type_id": 2,
  #   "details": "Antispam e antivírus, Aplicativo Type App, Painel de controle, Versão mobile.",
  #   "created_at": "2021-03-13T20:18:19.624Z",
  #   "updated_at": "2021-03-13T20:18:19.624Z",
  #   "status": "activated"
  #   },
  #   {
  #   "id": 3,
  #   "name": "Cloud pro 1 gb",
  #   "description": "1 GB de memória, 2 vCPUs, 20 GB de disco SSD 1 TB de transferência.",
  #   "product_type_id": 3,
  #   "details": "Disco SSD, Escalabilidade vertical Acesso Root/Admin, Serviços adicionais.",
  #   "created_at": "2021-03-13T20:18:19.707Z",
  #   "updated_at": "2021-03-13T20:18:19.707Z",
  #   "status": "disabled"
  #   }
  # ]
  def index
    render json: Plan.all, status: :ok
  end

  # Rota para um plano
  #
  # = Exemplo de Request
  #   GET /api/v1/plans/:id
  #
  # = Exemplo de Response
  #   => Status Code: 200 OK
  # {
  #   "id": 2,
  #   "name": "Initial",
  #   "description": "25 caixas postais, 15 GB por caixa A partir de R$ 1,05 por caixa.",
  #   "product_type_id": 2,
  #   "details": "Antispam e antivírus, Aplicativo Type App, Painel de controle, Versão mobile.",
  #   "created_at": "2021-03-13T20:18:19.624Z",
  #   "updated_at": "2021-03-13T20:18:19.624Z",
  #   "status": "activated"
  # }
  def show
    plan = Plan.find_by(id: find_plan.fetch(:id))
    if plan.present?
      render json: plan, status: :ok
    else
      render body: nil, status: :not_found
    end
  end

  # Rota para planos de um produto específico
  #
  # = Exemplo de Request
  #   GET /api/v1/product_types/:product_type_id/plans
  #
  # = Exemplo de Response
  #   => Status Code: 200 OK
  # [
  #   {
  #   "id": 2,
  #   "name": "Initial",
  #   "description": "25 caixas postais, 15 GB por caixa A partir de R$ 1,05 por caixa.",
  #   "product_type_id": 2,
  #   "details": "Antispam e antivírus, Aplicativo Type App, Painel de controle, Versão mobile.",
  #   "created_at": "2021-03-13T20:18:19.624Z",
  #   "updated_at": "2021-03-13T20:18:19.624Z",
  #   "status": "activated"
  #   },
  #   {
  #   "id": 4,
  #   "name": "Basico",
  #   "description": "descrição basico",
  #   "product_type_id": 2,
  #   "details": "detalhes basico",
  #   "created_at": "2021-03-28T05:36:32.609Z",
  #   "updated_at": "2021-03-28T05:36:32.609Z",
  #   "status": "activated"
  #   }
  # ]
  def product_type
    plans = Plan.where(product_type: find_product.fetch(:product_type_id))
    render json: plans, status: :ok
  end

  private

  def find_plan
    params.permit(:id)
  end

  def find_product
    params.permit(:product_type_id)
  end
end
