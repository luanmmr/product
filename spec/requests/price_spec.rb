require 'rails_helper'

describe 'Price view API' do
  context '#index' do
    context 'When a plan is found' do
      context 'When plan is activated' do
        context 'When there are recorded prices for the plan' do
          it 'render a json with all plan prices' do
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
        end
        context 'Where there are not recorded prices for the plan' do
          it 'return a empty erray' do
            plan = create(:plan)
    
            get "/api/v1/plans/#{plan.id}/prices"
            json = JSON.parse(response.body, symbolize_names: true)
    
            expect(response).to have_http_status(:ok)
            expect(json). to eql([])
          end
        end
      end

      context 'When plan is not activated' do
        it 'return status code 404' do
          plan = create(:plan, status: :disabled)
          monthly = create(:periodicity, name: 'Mensal')
          create(:price, plan_price: 20, plan: plan,
                         periodicity: monthly)
    
          get "/api/v1/plans/#{plan.id}/prices"
    
          expect(response).to have_http_status(:not_found)
          expect(response.body).to eql("")
        end
      end
    end

    context 'When a plan is not found' do
      it 'return status code 404' do
        get '/api/v1/plans/1/prices'
  
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
