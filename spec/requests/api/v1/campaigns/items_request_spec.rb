require 'rails_helper'

RSpec.describe "campaign items API" do
  before(:each) do
    @item1 = create(:item)
    @item2 = create(:item)
    @campaign1 = create(:campaign)
    @campaign1.items << [@item1, @item2]
  end

  describe "Campaign Items Index" do
    it "returns all items and their attributes for a specific campaign" do
      get "/api/v1/campaigns/#{@campaign1.id}/items"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items).to be_an(Array)
      #expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item[:attributes]).to have_key(:campaign_id)
        expect(item[:attributes][:campaign_id]).to be_a(Integer)

        expect(item[:attributes]).to have_key(:item_id)
        expect(item[:attributes][:item_id]).to be_an(Integer)

        expect(item[:attributes]).to have_key(:quantity_owned)
        expect(item[:attributes][:quantity_owned]).to be_an(Integer)

        expect(item[:relationships]).to have_key(:campaign)
        expect(item[:relationships][:campaign]).to be_an(Hash)

        expect(item[:relationships]).to have_key(:item)
        expect(item[:relationships][:item]).to be_an(Hash)
      end
    end

    it "returns a 404 status and error message when an invalid campaign id is passed in" do
      get "/api/v1/campaigns/123123/items"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Campaign with 'id'=123123")
    end
  end
end
