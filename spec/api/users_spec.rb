require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '/users' do
    describe 'GET' do
    end

    describe 'POST' do
    end
  end

  describe '/users/:id' do
    before { @user = FactoryGirl.create(:user) }

    describe 'GET' do
      context 'with a valid id' do
        before { get "/users/#{@user.id}.json" }

        it 'returns 200' do
          expect(response).to be_success
        end

        it 'returns public attributes for the user' do
          expect(json['id']).to eq @user.id
          expect(json['name']).to eq @user.name
          expect(json['email']).to eq @user.email
          expect(json['institution']).to eq @user.institution
          # DateTime objects will be in ISO8601 format with 3 fraction digits.
          expect(json['created_at']).to eq @user.created_at.iso8601(3)
          expect(json['updated_at']).to eq @user.updated_at.iso8601(3)
        end

        it 'does not return private attributes for the user' do
          expect(json['encrypted_password']).to be nil
        end
      end

      context 'with an invalid id' do
        before { get "/users/#{User.count + 1}.json" }

        it 'returns 404' do
          expect(response.status).to be 404
        end
      end
    end

    describe 'PUT' do
    end

    describe 'DELETE' do
    end
  end

  describe '/users/:id/edit' do
    describe 'GET' do
    end
  end
end