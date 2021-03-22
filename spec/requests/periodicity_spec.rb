require 'rails_helper'

describe 'Periodicity view API' do
  context 'index' do
    it 'renders a json successfuly - all periodicities' do
      monthly = create(:periodicity, name: 'Mensal')
      quarterly = create(:periodicity, name: 'Trimestral')
      semiannual = create(:periodicity, name: 'Semestral')

      get api_v1_periodicities_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[0][:name]).to eq(monthly.name)
      expect(json[0][:period]).to eq(monthly.period)
      expect(json[1][:name]).to eq(quarterly.name)
      expect(json[1][:period]).to eq(quarterly.period)
      expect(json[2][:name]).to eq(semiannual.name)
      expect(json[2][:period]).to eq(semiannual.period)
    end

    it 'render a blank json successfully' do
      get api_v1_periodicities_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json).to eq([])
      expect(response).not_to have_http_status(:bad_request)
    end
  end
end
