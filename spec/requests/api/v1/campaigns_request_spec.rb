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

  describe "Campaign Create" do
    it "creates a new campaign record when passed the required attributes" do
      campaign_params = ({ name: "Turing Campaign" })

      headers = {"CONTENT_TYPE" => "application/json"}
    
      post "/api/v1/campaigns", headers: headers, params: JSON.generate(campaign: campaign_params)
      created_campaign = Campaign.last
    
      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(created_campaign.name).to eq("Turing Campaign")
      expect(created_campaign.week).to eq(0)
      expect(created_campaign.animal_products).to eq(0)
      expect(created_campaign.cloth).to eq(0)
      expect(created_campaign.farmed_goods).to eq(0)
      expect(created_campaign.food).to eq(0)
      expect(created_campaign.foraged_goods).to eq(0)
      expect(created_campaign.metal).to eq(0)
      expect(created_campaign.monster_parts).to eq(0)
      expect(created_campaign.stone).to eq(0)
      expect(created_campaign.wood).to eq(0)
      expect(created_campaign.villagers).to eq(120)
    end

    # if we update the campaign create page to have fields for things other than names, add a test here for proving that you can enter 
    # a value for any of the resources as well as name and it'll create the campaign with that value.

    it "returns a 400 status and error message when missing the name attribute" do 
      campaign_params = ({ name: "" })

      headers = {"CONTENT_TYPE" => "application/json"}
    
      post "/api/v1/campaigns", headers: headers, params: JSON.generate(campaign: campaign_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:title]).to eq("Validation failed: Name can't be blank")
    end
  end

  describe "Campaign Update" do 
    it "updates a campaigns attributes and returns the campaign" do
      id = create(:campaign).id
      original_campaign = Campaign.last

      # the below would represent updating the wood and villagers field while leaving the rest as is
      campaign_params = { name: original_campaign.name,
                          week: 0,
                          animal_products: 0,
                          cloth: 0,
                          farmed_goods: 0,
                          food: 0,
                          foraged_goods: 0,
                          metal: 0,
                          monster_parts: 0,
                          stone: 0,
                          wood: 10,
                          villagers: 200 }

      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/campaigns/#{id}", headers: headers, params: JSON.generate({campaign: campaign_params})

      campaign = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(campaign[:attributes][:name]).to eq(original_campaign.name)
      expect(campaign[:attributes][:stone]).to eq(original_campaign.stone)
      expect(campaign[:attributes][:wood]).to eq(10)
      expect(campaign[:attributes][:villagers]).to eq(200)
    end

    it 'returns a 422 status and error message when trying to update a field to nil' do
      id = create(:campaign).id

      campaign_params = { name: Campaign.last.name,
                          week: 0,
                          animal_products: "",
                          cloth: 0,
                          farmed_goods: 0,
                          food: 0,
                          foraged_goods: 0,
                          metal: 0,
                          monster_parts: 0,
                          stone: 0,
                          wood: 10,
                          villagers: 200 }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/campaigns/#{id}", headers: headers, params: JSON.generate({campaign: campaign_params})
      
      expect(response).to_not be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:title]).to eq("Validation failed: Animal products can't be blank, Animal products is not a number")
    end

    it 'returns a 404 status and error message when an invalid campaign_id is passed in' do
      campaign_params = { name: Campaign.last.name,
                          week: 0,
                          animal_products: 0,
                          cloth: 0,
                          farmed_goods: 0,
                          food: 0,
                          foraged_goods: 0,
                          metal: 0,
                          monster_parts: 0,
                          stone: 0,
                          wood: 10,
                          villagers: 200 }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/campaigns/123123", headers: headers, params: JSON.generate({campaign: campaign_params})
      
      expect(response).to_not be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Campaign with 'id'=123123")
    end

    it "returns a 422 status and error message when an trying to update any of the integer fields with a non-integer value" do 
      id = create(:campaign).id
      campaign_params = { wood: "one"}
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/campaigns/#{id}", headers: headers, params:  JSON.generate({campaign: campaign_params})

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:title]).to eq("Validation failed: Wood is not a number")
    end

    it "returns a 422 status and error message when an trying to update any of the integer fields with a number less than 0" do 
      id = create(:campaign).id
      campaign_params = { wood: -1}
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/campaigns/#{id}", headers: headers, params:  JSON.generate({campaign: campaign_params})

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:title]).to eq("Validation failed: Wood must be greater than or equal to 0")
    end

    it "returns a 422 status and error message when an trying to update any of the integer fields with a float" do 
      id = create(:campaign).id
      campaign_params = { wood: 1.1 }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/campaigns/#{id}", headers: headers, params:  JSON.generate({campaign: campaign_params})

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:title]).to eq("Validation failed: Wood must be an integer")
    end
  end
end