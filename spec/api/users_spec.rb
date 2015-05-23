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
          # one error for :name, :institution, :email, :password
          expect(json.size).to be 4
        end

        it 'returns details about the errors' do
          # In this example, email and password (among others) are missing,
          # so some of the errors relate to those attributes
          expect(json['email']).to include 'is invalid'
          expect(json['email']).to include "can't be blank"
          expect(json['password']).to include "can't be blank"
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
      context 'with a valid id' do
        before do
          @old_name = @user.name
          @old_institution = @user.institution
          @old_updated_at = @user.updated_at
          put "/users/#{@user.id}.json", user: params
        end

        context 'with valid params' do
          let(:params) { { name: 'new name', institution: 'new institution' } }
          before { @user.reload }

          it 'returns 200' do
            expect(response).to be_success
          end

          it 'returns the user as JSON' do
            expect(json['id']).to eq @user.id
            expect(json['name']).to eq @user.name
            expect(json['institution']).to eq @user.institution
            expect(json['email']).to eq @user.email
            expect(json['created_at']).to eq @user.created_at.iso8601(3)
            expect(json['updated_at']).to eq @user.updated_at.iso8601(3)
          end

          it 'updates the user' do
            expect(@user.updated_at).to be > @old_updated_at
            expect(@user.name).to_not eq @old_name
            expect(@user.institution).to_not eq @old_institution
          end
        end

        context 'with invalid params' do
          let(:params) { { name: '', institution: '' } }

          it 'returns unprocessable entity' do
            expect(response.status).to eq 422
          end

          it 'returns a list of errors' do
            # one error for :name, :institution
            expect(json.size).to be 2
          end

          it 'returns details about the errors' do
            expect(json['name']).to include "can't be blank"
            expect(json['institution']).to include "can't be blank"
          end

          it 'does not update the user' do
            @user.reload
            expect(@user.updated_at).to eq @old_updated_at
            expect(@user.name).to eq @old_name
            expect(@user.institution).to eq @old_institution
          end
        end
      end

      context 'with an invalid id' do
        before { put "/users/#{User.count + 1}.json" }

        it 'returns 404' do
          expect(response.status).to eq 404
        end
      end
    end

    describe 'DELETE' do
      before { @old_count = User.count }

      context 'with a valid id' do
        before { delete "/users/#{@user.id}.json" }

        it 'returns success' do
          expect(response).to be_success
        end

        it 'returns no content' do
          expect { json }.to raise_error JSON::ParserError
        end

        it 'destroys the user' do
          expect(User.count).to eq (@old_count - 1)
        end
      end

      context 'with an invalid id' do
        before { delete "/users/#{User.count + 1}.json" }

        it 'returns 404' do
          expect(response.status).to eq 404
        end

        it 'returns no content' do
          expect { json }.to raise_error JSON::ParserError
        end

        it 'does not destroy a user' do
          expect(User.count).to eq @old_count
        end
      end
    end
  end
end
