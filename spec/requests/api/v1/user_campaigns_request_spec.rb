require 'rails_helper'

RSpec.describe "UserCampaigns API" do
  before(:each) do
    @campaign1 = create(:campaign)
    @user1 = create(:user)
    @character1 = create(:character, user_id: @user1.id)
  end

  describe "UserCampaign Create" do
    it "creates a new user campaign record when passed the required attributes" do
      user_campaign_params = (
        {
          user_id: @user1.id,
          campaign_id: @campaign1.id,
          character_id: @character1.id,
          role: 0
        }
        )

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/user_campaigns", headers: headers, params: JSON.generate(user_campaign: user_campaign_params)
      created_user_campaign = UserCampaign.last

      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(created_user_campaign.user).to eq(@user1)
      expect(created_user_campaign.campaign).to eq(@campaign1)
      expect(created_user_campaign.character).to eq(@character1)
      expect(created_user_campaign.role).to eq("party_member")
    end

    it "returns a 422 status and error message when missing any required attribute" do
      @user1 = create(:user)
      user_campaign_params = (
        {
          user_id: @user1.id,
          character_id: @character1.id,
          role: 0
        }
        )

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/user_campaigns", headers: headers, params: JSON.generate(user_campaign: user_campaign_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:title]).to eq("Validation failed: Campaign must exist, Campaign can't be blank")
    end
  end

  describe "User Campaigns Index" do
    it "returns all user campaigns and their attributes for a specific user" do
      create(:user_campaign, user: @user1, campaign_id: @campaign1.id, character_id: @character1.id)

      get "/api/v1/users/#{@user1.uid}/user_campaigns"

      campaigns = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(campaigns).to be_an(Array)
      expect(campaigns.count).to eq(1)

      campaigns.each do |campaign|
        expect(campaign).to have_key(:id)
        expect(campaign[:id]).to be_a(String)

        expect(campaign).to have_key(:type)
        expect(campaign[:type]).to eq('user_campaign')

        expect(campaign[:attributes]).to have_key(:role)
        expect(campaign[:attributes][:role]).to be_a(String)

        expect(campaign[:relationships]).to have_key(:user)
        expect(campaign[:relationships][:user]).to be_an(Hash)

        expect(campaign[:relationships]).to have_key(:campaign)
        expect(campaign[:relationships][:campaign]).to be_a(Hash)

        expect(campaign[:relationships]).to have_key(:character)
        expect(campaign[:relationships][:character]).to be_a(Hash)
      end
    end

    it "returns a 400 status and error message when an invalid user id is passed in" do
      get "/api/v1/users/12312312312/user_campaigns"
      
      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("400")
      expect(data[:errors].first[:title]).to eq("Couldn't find that user")
    end
  end

  describe "UserCampaign Update" do
    it "updates a UserCampaigns attributes and returns the UserCampaign" do
      user = create(:user)
      character = create(:character, user_id: user.id)
      original_user_campaign = create(:user_campaign, character_id: nil, role: 0)
      original_user_campaign_id = original_user_campaign.id

      user_campaign_params = {
        character_id: character.id
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/user_campaigns/#{original_user_campaign_id}", headers: headers, params: JSON.generate({user_campaign: user_campaign_params})

      updated_user_campaign = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(updated_user_campaign[:id].to_i).to eq(original_user_campaign_id)
      expect(updated_user_campaign[:relationships][:character][:data][:id].to_i).to eq(character.id)
    end
  end
end
