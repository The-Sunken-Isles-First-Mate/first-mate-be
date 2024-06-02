require 'rails_helper'

RSpec.describe UserCampaign, type: :model do
  describe '#relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:campaign) }
    it { should belong_to(:character).optional }
  end

  describe '#validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:campaign_id) }
    it { should validate_presence_of(:role) }
  end

  it 'exists and has attributes' do
    user_campaign = create(:user_campaign)

    expect(user_campaign).to be_a UserCampaign
    expect(user_campaign.user).to be_a User
    expect(user_campaign.campaign).to be_a Campaign
    expect(user_campaign.character).to be_a Character
    expect(user_campaign.role).to be_a String
  end
end
