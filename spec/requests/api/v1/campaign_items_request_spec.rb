require 'rails_helper'

RSpec.describe "CampaignItems API" do
  describe "CampaignItem Create" do
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

    describe "sad paths" do
      before(:each) do
        @item1 = create(:item)
        @campaign1 = create(:campaign)
      end

      it "returns a 400 status and error message when the campaign_id doesn't exist" do
        campaign_item_params = ({ campaign_id: 123123,
                                  item_id: @item1.id,
                                  quantity_owned: 0 })

        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/campaign_items", headers: headers, params: JSON.generate(campaign_item: campaign_item_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:status]).to eq("422")
        expect(data[:errors].first[:title]).to eq("Validation failed: Campaign must exist")
      end

      it "returns a 400 status and error message when missing the item_id attribute" do
        campaign_item_params = ({ campaign_id: @campaign1.id,
                                  item_id: "",
                                  quantity_owned: 0 })

        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/campaign_items", headers: headers, params: JSON.generate(campaign_item: campaign_item_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:status]).to eq("422")
        expect(data[:errors].first[:title]).to eq("Validation failed: Item must exist, Item can't be blank")
      end
    end
  end

  describe "CampaignItem Update" do
    describe "happy path" do
      before(:each) do
        @item1 = create(:item)
        @campaign1 = create(:campaign)
        @campaign_item1 = create(:campaign_item, campaign_id: @campaign1.id, item_id: @item1.id, quantity_owned: 1)
      end

      it "updates a campaign_items attributes and returns the campaign_item" do
        id = @campaign_item1.id
        original_campaign_item = CampaignItem.last

        # the below would represent updating the wood and villagers field while leaving the rest as is
        campaign_item_params = { campaign_id: @campaign1.id,
                                 item_id: @item1.id,
                                 quantity_owned: 10
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        patch "/api/v1/campaign_items/#{id}", headers: headers, params: JSON.generate({campaign_item: campaign_item_params})

        campaign_item = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response).to be_successful
        expect(campaign_item[:attributes][:campaign_id]).to eq(original_campaign_item.campaign_id)
        expect(campaign_item[:attributes][:item_id]).to eq(original_campaign_item.item_id)
        expect(campaign_item[:attributes][:quantity_owned]).to eq(10)

        expect(campaign_item[:relationships]).to have_key((:campaign))
        expect(campaign_item[:relationships][:campaign]).to be_a Hash

        expect(campaign_item[:relationships]).to have_key((:item))
        expect(campaign_item[:relationships][:item]).to be_a Hash
      end
    end

    describe "sad path" do
      before(:each) do
        @item1 = create(:item)
        @campaign1 = create(:campaign)
      end

      it "returns a 404 status and error message when an invalid campaign_item id is passed in" do
        campaign_item_params = { campaign_id: @campaign1.id,
        item_id: @item1.id,
        quantity_owned: 10
      }

        headers = {"CONTENT_TYPE" => "application/json"}

        patch "/api/v1/campaign_items/123123", headers: headers, params: JSON.generate({campaign_item: campaign_item_params})

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:status]).to eq("404")
        expect(data[:errors].first[:title]).to eq("Couldn't find CampaignItem with 'id'=123123")
      end
    end
  end
end
