require 'rails_helper'

RSpec.describe "Campaigns API" do
  before(:each) do
    @campaign1 = create(:campaign)

  end
  describe "Campaign Show" do
    it "returns all campaign attributes for a specific campaign" do
      get "/api/v1/campaigns/#{@campaign1.id}"

      campaign = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(campaign).to have_key(:id)
      expect(campaign[:id]).to be_an(String)

      expect(campaign[:attributes]).to have_key(:name)
      expect(campaign[:attributes][:name]).to be_a(String)

      expect(campaign[:attributes]).to have_key(:week)
      expect(campaign[:attributes][:week]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:animal_products)
      expect(campaign[:attributes][:animal_products]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:cloth)
      expect(campaign[:attributes][:cloth]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:farmed_goods)
      expect(campaign[:attributes][:farmed_goods]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:food)
      expect(campaign[:attributes][:food]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:foraged_goods)
      expect(campaign[:attributes][:foraged_goods]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:metal)
      expect(campaign[:attributes][:metal]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:monster_parts)
      expect(campaign[:attributes][:monster_parts]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:stone)
      expect(campaign[:attributes][:stone]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:wood)
      expect(campaign[:attributes][:wood]).to be_an(Integer)
      
      expect(campaign[:attributes]).to have_key(:villagers)
      expect(campaign[:attributes][:villagers]).to be_an(Integer)
    end

    it "returns a 404 status and error message when an invalid campaign id is passed in" do 
      get "/api/v1/campaigns/123123" 

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Campaign with 'id'=123123")
    end
  end
end