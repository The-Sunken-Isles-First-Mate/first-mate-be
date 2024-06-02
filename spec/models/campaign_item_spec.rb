require 'rails_helper'

RSpec.describe CampaignItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:campaign) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it {should validate_presence_of(:campaign_id)}
    it {should validate_presence_of(:item_id)}
    it {should validate_presence_of(:quantity_owned)}
  end
end