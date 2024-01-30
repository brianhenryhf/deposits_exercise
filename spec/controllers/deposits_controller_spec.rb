require 'rails_helper'

RSpec.describe DepositsController, type: :controller do
  describe '#index' do
    let(:tradeline) { FactoryBot.create :tradeline }

    it 'responds with a 200' do
      get :index, format: :json, params: { tradeline_id: tradeline.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:deposit) { FactoryBot.create :deposit }

    it 'responds with a 200' do
      get :show, format: :json, params: { id: deposit.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the deposit is not found' do
      it 'responds with a 404' do
        get :show, format: :json,params: { id: 1000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:tradeline) { FactoryBot.create :tradeline }

    context 'if amount is not in excess for tradeline' do
      it 'responds with a 204' do
        post :create, format: :json, params: {
          tradeline_id: tradeline.id,
          deposit: {
            deposit_date: '2024-01-01',
            amount: 39.24
          }
        }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'if amount is in excess for tradeline' do
      it 'responds with a 422' do
        post :create, format: :json, params: {
          tradeline_id: tradeline.id,
          deposit: {
            deposit_date: '2024-01-01',
            amount: 999999999.99
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
