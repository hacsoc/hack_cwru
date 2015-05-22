require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '/users' do
    describe 'GET' do
      before do
        @users = FactoryGirl.create_list(:user, 2)
        get '/users.json'
      end

      it 'returns 200' do
        expect(response).to be_success
      end

      it 'returns a list of users' do
        expect(json.length).to eq @users.length
      end

      it 'returns some public attributes about the users' do
        json.each_with_index do |data, index|
          user = @users[index]
          expect(data['id']).to eq user.id
          expect(data['name']).to eq user.name
          expect(data['institution']).to eq user.institution
        end
      end

      it 'returns a url for each user' do
        json.each_with_index do |data, index|
          expect(data['url']).to eq user_url(@users[index], format: :json)
        end
      end
    end

    describe 'POST' do
      context 'with valid data' do
        before do
          @old_count = User.count
          @attributes = FactoryGirl.attributes_for(:user)
          post '/users.json', user: @attributes
        end

        it 'returns created' do
          expect(response.status).to eq 201
        end

        it 'creates a user record' do
          expect(User.count).to eq (@old_count + 1)
        end

        it 'returns the created user as json' do
          expect(json['name']).to eq @attributes[:name]
          expect(json['email']).to eq @attributes[:email]
          # id, created_at and update_at are also returned in the JSON,
          # but we have no way to know what those values should be in this test
          expect(json['id']).to_not be nil
          expect(json['created_at']).to_not be nil
          expect(json['updated_at']).to_not be nil
        end
      end

      context 'with invalid data' do
        before { post '/users.json', user: User.new.attributes }

        it 'returns unprocessable entity' do
          expect(response.status).to eq 422
        end

        it 'returns a list of errors' do
          expect(json.empty?).to be false
        end

        it 'returns details about the errors' do
          # In this example, email and password (among others) are missing,
          # so some of the errors relate to those attributes
          expect(json['email'].include?('is invalid')).to be true
          expect(json['email'].include?("can't be blank")).to be true
          expect(json['password'].include?("can't be blank")).to be true
        end
      end
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
