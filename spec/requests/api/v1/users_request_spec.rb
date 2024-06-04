require 'rails_helper'

RSpec.describe "Users API" do
  before(:each) do
    @user1 = create(:user)
  end

  describe "User Show" do
    it "returns all user attributes for a specific user" do
      valid_attr = {
        user: {
          username: @user1.username,
          token: @user1.token
        }
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      get "/api/v1/users/#{@user1.uid}", params: valid_attr, headers: headers

      user = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(user).to have_key(:id)
      expect(user[:id]).to be_an(String)

      expect(user).to have_key(:type)
      expect(user[:type]).to eq('user')

      expect(user[:attributes]).to have_key(:uid)
      expect(user[:attributes][:uid]).to be_an(String)

      expect(user[:attributes]).to have_key(:username)
      expect(user[:attributes][:username]).to be_an(String)

      expect(user[:attributes]).to have_key(:token)
      expect(user[:attributes][:token]).to be_an(String)

      expect(user[:relationships]).to have_key(:user_campaigns)
      expect(user[:relationships][:user_campaigns]).to be_a Hash

      expect(user[:relationships]).to have_key(:campaigns)
      expect(user[:relationships][:campaigns]).to be_a Hash

      expect(user[:relationships]).to have_key(:characters)
      expect(user[:relationships][:characters]).to be_a Hash

    end

    it "updates a users username and token if passed new info in the params" do
      valid_attr = {
        user: {
          username: 'coolusername',
          token: 'abc123def456'
        }
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      get "/api/v1/users/#{@user1.uid}", params: valid_attr, headers: headers

      user = User.find(@user1.id)
      expect(user.id).to eq(@user1.id)
      expect(user.uid).to eq(@user1.uid)
      expect(user.username).to eq('coolusername')
      expect(user.token).to eq('abc123def456')
    end

    it "creates a user with the passed UID if it doesn't already exist and then returns that users info" do
      valid_attr = {
        user: {
          username: 'coolusername',
          token: 'abc123def456'
        }
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      get "/api/v1/users/123123", params: valid_attr, headers: headers

      user = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(user).to have_key(:id)
      expect(user[:id]).to be_an(String)

      expect(user).to have_key(:type)
      expect(user[:type]).to eq('user')

      expect(user[:attributes]).to have_key(:uid)
      expect(user[:attributes][:uid]).to be_an(String)
      expect(user[:attributes][:uid]).to eq('123123')

      expect(user[:attributes]).to have_key(:username)
      expect(user[:attributes][:username]).to be_an(String)

      expect(user[:attributes]).to have_key(:token)
      expect(user[:attributes][:token]).to be_an(String)
    end
  end

  describe '#Sad Paths' do
    describe 'User Show Sad Path' do
      it 'returns a 400 status and error message when no username or no token is passed in' do
        invalid_attr = {
          user: {
            username: 'coolusername'
          }
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        get "/api/v1/users/123123", params: invalid_attr, headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:status]).to eq("400")
        expect(data[:errors].first[:title]).to eq("Username or Token cannot be missing")
      end
    end
  end
end
