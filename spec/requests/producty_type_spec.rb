require 'rails_helper'

describe 'Product Type view API' do
  context 'index' do
    it 'render a json with all products' do
      product_one = create(:product_type, name: 'Hospedagem de Sites')
      product_other = create(:product_type, name: 'Email')

      get '/api/v1/product_types'
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[0][:name]).to eq(product_one.name)
      expect(json[0][:product_key]).to eq(product_one.product_key)
      expect(json[1][:name]).to eq(product_other.name)
      expect(json[1][:product_key]).to eq(product_other.product_key)
    end

    it 'render a json blank if there is no record product type' do
      get '/api/v1/product_types'
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json).to eq([])
    end
  end

  context 'show' do
    it 'render a json with a found product type' do
      product = create(:product_type)

      get "/api/v1/product_types/#{product.id}"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:name]).to eq(product.name)
      expect(json[:id]).to eq(product.id)
    end

    it 'return a error message when id does not existing' do
      get '/api/v1/product_types/1'

      expect(response.body).to include('Couldn\'t find ProductType with')
      expect(response).to have_http_status(:not_found)
    end
  end
end
