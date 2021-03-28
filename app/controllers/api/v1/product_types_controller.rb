class Api::V1::ProductTypesController < Api::V1::ApiController
  # Rota para todas os produtos
  #
  # = Exemplo de Request
  #   GET /api/v1/product_types
  #
  # = Exemplo de Response
  #   => Status Code: 200 OK
  # [
  #   {
  #   "id": 1,
  #   "name": "Hospedagem de sites",
  #   "description": "É um espaço em servidor para que você possa armazenar o seu site.",
  #   "product_key": "HEMS8019",
  #   "created_at": "2021-03-13T20:18:19.470Z",
  #   "updated_at": "2021-03-13T20:18:19.470Z"
  #   },
  #   {
  #   "id": 2,
  #   "name": "Email",
  #   "description": "É um serviço de correio eletrônico para envios e recebimentos de mensagens.",
  #   "product_key": "EAIL6486",
  #   "created_at": "2021-03-13T20:18:19.482Z",
  #   "updated_at": "2021-03-13T20:18:19.482Z"
  #   }
  # ]
  def index
    render json: ProductType.all, status: :ok
  end

  # Rota para um produto
  #
  # = Exemplo de Request
  #   GET /api/v1/product_types/:id
  #
  # = Exemplo de Response
  #   => Status Code: 200 OK
  # {
  #   "id": 1,
  #   "name": "Hospedagem de sites",
  #   "description": "É um espaço em servidor para que você possa armazenar o seu site.",
  #   "product_key": "HEMS8019",
  #   "created_at": "2021-03-13T20:18:19.470Z",
  #   "updated_at": "2021-03-13T20:18:19.470Z"
  # }
  def show
    product = ProductType.find_by(id: find_product.fetch(:id))
    if product.present?
      render json: product, status: :ok
    else
      render body: nil, status: :not_found
    end
  end


  private

  def find_product
    params.permit(:id)
  end
end
