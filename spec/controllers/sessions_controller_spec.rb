# spec/controllers/api/v1/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) {
      coach = FactoryBot.create(:coach)
      client = FactoryBot.create(:client)
      { coach_hash_id: coach.coach_hash_id, client_hash_id: client.client_hash_id, start: Time.now, duration: 60 }
    }

    let(:invalid_attributes) {
      { coach_hash_id: 'coach1', client_hash_id: '', start: Time.now, duration: 0 }
    }

    context 'with valid params' do
      it 'creates a new Session' do
        expect {
          post :create, params: { session: valid_attributes }
        }.to change(Session, :count).by(1)
      end

      it 'renders a JSON response with the new session' do
        post :create, params: { session: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['session']).not_to be_nil
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new session' do
        post :create, params: { session: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['errors']).not_to be_nil
      end
    end
  end
end