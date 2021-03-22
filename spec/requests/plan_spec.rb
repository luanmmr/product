require 'rails_helper'

describe 'Plan view API' do
  context 'index' do
    it 'renders a json successfully - all plans' do
      product_hosp = create(:product_type, name: 'Hospedagem')
      product_email = create(:product_type, name: 'Email')
      plan_go = create(:plan, name: 'Go', product_type: product_hosp,
                              description: 'Descrição do GO',
                              details: 'Detalhes do Go')
      plan_initial = create(:plan, name: 'Initial', product_type: product_email,
                                   description: 'Descrição do Initial',
                                   details: 'Detalhes do Initial',
                                   status: :disabled)

      get api_v1_plans_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[0][:name]).to eq(plan_go.name)
      expect(json[0][:product_type_id]).to eq(plan_go.product_type_id)
      expect(json[0][:description]).to eq(plan_go.description)
      expect(json[0][:details]).to eq(plan_go.details)
      expect(json[0][:status]).to eq(plan_go.status)
      expect(json[1][:name]).to eq(plan_initial.name)
      expect(json[1][:product_type_id]).to eq(plan_initial.product_type_id)
      expect(json[1][:description]).to eq(plan_initial.description)
      expect(json[1][:details]).to eq(plan_initial.details)
      expect(json[1][:status]).to eq(plan_initial.status)
    end

    it 'renders a blank json sucessfully' do
      get api_v1_plans_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json).to eq([])
    end
  end

  context 'show' do
    it 'renders a json successfully' do
      plan = create(:plan)

      get api_v1_plan_path(plan)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:name]).to eq(plan.name)
      expect(json[:description]).to eq(plan.description)
      expect(json[:details]).to eq(plan.details)
      expect(json[:status]).to eq(plan.status)
    end

    it 'throw a error if not found a exist existing id' do
      get api_v1_plan_path(20)

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Couldn\'t find Plan with')
    end
  end

  context 'product_type' do
    it 'render a json with with all product plans' do
      product = create(:product_type, name: 'Hospedagem de Sites')
      plan = create(:plan, name: 'Go', product_type: product)
      plan_other = create(:plan, name: 'HP I', product_type: product)
      plan_another = create(:plan, name: 'HP II', product_type: product)

      get "/api/v1/product_types/#{product.id}/plans"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[0][:name]).to eq(plan.name)
      expect(json[0][:product_type_id]).to eq(product.id)
      expect(json[1][:name]).to eq(plan_other.name)
      expect(json[1][:product_type_id]).to eq(product.id)
      expect(json[2][:name]).to eq(plan_another.name)
      expect(json[2][:product_type_id]).to eq(product.id)
    end

    it 'render a blank json when product has no associated plans' do
      get '/api/v1/product_types/1/plans'
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json).to eq([])
    end
  end
end
