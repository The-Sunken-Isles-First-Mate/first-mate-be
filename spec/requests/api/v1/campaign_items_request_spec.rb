require 'rails_helper'

RSpec.describe "campaign items API" do
  describe "campaign item create" do
    describe "happy path" do 
      before(:each) do
        @item1 = create(:item)
        @campaign1 = create(:campaign)
      end

      it "creates a new campaign item" do
        campaign_item_params = ({ campaign_id: @campaign1.id,
                                  item_id: @item1.id })

        headers = {"CONTENT_TYPE" => "application/json"}
      
        post "/api/v1/campaign_items", headers: headers, params: JSON.generate(campaign_item: campaign_item_params)
        created_campaign_item = CampaignItem.last
      
        expect(response).to be_successful
        expect(response.status).to eq 201
        expect(created_campaign_item.campaign_id).to eq(@campaign1.id)
        expect(created_campaign_item.item_id).to eq(@item1.id)
        expect(created_campaign_item.quantity_owned).to eq(0)
      end
    end
  end
end