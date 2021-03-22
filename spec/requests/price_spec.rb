require 'rails_helper'

describe 'Price view API' do
  context 'index' do
    it 'render a json with activated plan prices' do
      plan = create(:plan)
      monthly = create(:periodicity, name: 'Mensal')
      quarterly = create(:periodicity, name: 'Trimestral')
      semiannual = create(:periodicity, name: 'Semestral')
      price_one = create(:price, plan_price: 20, plan: plan,
                                 periodicity: monthly)
      price_other = create(:price, plan_price: 60, plan: plan,
                                   periodicity: quarterly)
      price_another = create(:price, plan_price: 120, plan: plan,
                                     periodicity: semiannual)

      get "/api/v1/plans/#{plan.id}/prices"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[0][:plan_price].to_f).to eq(price_one.plan_price)
      expect(json[0][:periodicity_id]).to eq(monthly.id)
      expect(json[1][:plan_price].to_f).to eq(price_other.plan_price)
      expect(json[1][:periodicity_id]).to eq(quarterly.id)
      expect(json[2][:plan_price].to_f).to eq(price_another.plan_price)
      expect(json[2][:periodicity_id]).to eq(semiannual.id)
    end

    it 'throw error message when id does not existing' do
      get '/api/v1/plans/1/prices'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Couldn\'t find Plan with')
    end

    it 'return a empty array when there are no prices records for the plan' do
      plan = create(:plan)

      get "/api/v1/plans/#{plan.id}/prices"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json).to eq([])
    end

    it 'return a json only with activated plans prices' do
      product = create(:product_type)
      plan = create(:plan, name: 'Go', product_type: product, status: :disabled)
      monthly = create(:periodicity, name: 'Mensal')
      quarterly = create(:periodicity, name: 'Trimestral')
      create(:price, plan_price: 20, plan: plan,
                     periodicity: monthly)
      create(:price, plan_price: 60, plan: plan,
                     periodicity: quarterly)

      get "/api/v1/plans/#{plan.id}/prices"

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Couldn\'t find Plan with')
    end
  end
end
