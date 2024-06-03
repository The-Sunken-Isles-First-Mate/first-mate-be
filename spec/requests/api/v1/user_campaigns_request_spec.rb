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
end
