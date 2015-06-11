require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe '/session' do
    describe 'POST' do
      before { post '/session.json', session: params }

      context 'with valid email/password combo' do
        let(:password) { 'L33tPassword' }
        let(:user) { FactoryGirl.create(:user, password: password) }
        let(:params) { { email: user.email, password: password } }

        it 'returns 302' do
          expect(response.status).to eq 302
        end

        it 'signs in the user' do
          expect(response.headers).to have_key 'Set-Cookie'
          expect(response.headers['Set-Cookie']).to include 'remember_token'
          expect(response.headers['Set-Cookie']).to include 'hack_cwru_session'
        end
      end

      context 'with invalid email/password combo' do
        let(:params) { { email: '' } }

        it 'returns unauthorized' do
          expect(response).to be_unauthorized
        end
      end
    end
  end

  describe '/sign_out' do
    describe 'DELETE' do
      before { delete '/sign_out.json' }

      it 'returns 302' do
        expect(response.status).to eq 302
      end
    end
  end
end
