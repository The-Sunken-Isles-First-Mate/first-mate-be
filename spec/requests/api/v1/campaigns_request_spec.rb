require 'rails_helper'

RSpec.describe "Campaigns API" do


  describe "Campaign Show" do
    before(:each) do
      @campaign1 = create(:campaign)
    end

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

      expect(campaign[:relationships]).to have_key(:user_campaigns)
      expect(campaign[:relationships][:user_campaigns]).to be_a Hash

      expect(campaign[:relationships]).to have_key(:users)
      expect(campaign[:relationships][:users]).to be_a Hash

      expect(campaign[:relationships]).to have_key(:characters)
      expect(campaign[:relationships][:characters]).to be_a Hash

      expect(campaign[:relationships]).to have_key(:campaign_items)
      expect(campaign[:relationships][:campaign_items]).to be_a Hash

      expect(campaign[:relationships]).to have_key(:items)
      expect(campaign[:relationships][:items]).to be_a Hash
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
    before(:each) do
      @campaign1 = create(:campaign)
    end

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
    before(:each) do
      @campaign1 = create(:campaign)
    end

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

  describe "Campaign Advance Week" do
    before(:each) do
      @campaign = create(:campaign, food: 30, wood: 20, metal: 20, animal_products: 20, week: 2)

      @management_form = create(:management_form, campaign: @campaign, week: 2)

      @params = {
        campaign_id: @campaign.id,
        week: @campaign.week,
        animal_products: 30,
        cloth: 30,
        farmed_goods: 10,
        food: 0,
        foraged_goods: 0,
        metal: 0,
        monster_parts: 0,
        stone: 0,
        wood: 10,
        light_armor: 1,
        medium_armor: 1,
        heavy_armor: 0,
        simple_weapon: 0,
        martial_weapon: 0,
        ammunition: 0,
        adventuring_supplies: 0,
        assassins_blood: 0,
        malice: 0,
        midnight_tears: 0,
        serpent_venom: 0,
        truth_serum: 0,
        oil_of_slipperiness: 0,
        potion_of_climbing: 0,
        potion_of_healing: 0,
        potion_of_water_breathing: 0,
        barge: 0,
        coracle: 0,
        double_hulled_sailing_canoe: 0,
        keelboat: 0,
        raft: 1,
        single_hulled_sailing_canoe: 0,
        ballista: 0,
        cabin: 0,
        magical_defenses: 0,
        storage: 0
        }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/campaigns/#{@campaign.id}/advance_week", headers: headers, params: JSON.generate({campaign: @params})

      @campaign_response = JSON.parse(response.body, symbolize_names: true)[:data]
    end

    it "returns a 200 status and all updated campaign attributes" do
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(@campaign_response[:attributes][:name]).to eq(@campaign.name)
      expect(@campaign_response[:attributes][:food]).to eq(30)
      expect(@campaign_response[:attributes][:villagers]).to eq(120)
      expect(@campaign_response[:attributes][:week]).to eq(3)
      
      expect(@campaign.cloth).to eq 0
      expect(@campaign_response[:attributes][:cloth]).to eq(3)
      
      expect(@campaign.farmed_goods).to eq 0
      expect(@campaign_response[:attributes][:farmed_goods]).to eq(1)
      
      # item crafting for light armor, medium armor, and a raft consumes 2 animal_products, 3 metal, and 3 wood
      expect(@campaign.animal_products).to eq(20)
      # started with 20, gained 3 from villagers, spent 2 on crafting, resulting in 21 remaining.
      expect(@campaign_response[:attributes][:animal_products]).to eq(21)

      expect(@campaign.wood).to eq(20)
      # started with 20, gained 1 from villagers, spent 3 on crafting, resulting in 18 remaining.
      expect(@campaign_response[:attributes][:wood]).to eq(18)

      expect(@campaign.metal).to eq(20)
      # started with 20, gained 0 from villagers, spent 3 on crafting, resulting in 17 remaining.
      expect(@campaign_response[:attributes][:metal]).to eq(17)
    end

    it "creates a new management_form from the updated campaign data" do
      management_form = ManagementForm.last

      expect(management_form.campaign).to eq(@campaign)
      expect(management_form.week).to eq(3)
      expect(management_form.light_armor).to eq(0)
      expect(management_form.wood).to eq(0)
    end

    it "updates the quantity_owned of campaign_items for any items created " do
      light_armor_id = Item.all.find_by(name: "Light armor").id
      medium_armor_id = Item.all.find_by(name: "Medium armor").id
      raft_id = Item.all.find_by(name: "Raft").id
      
      light_armor_quant = @campaign.campaign_items.find_by(item_id: light_armor_id).quantity_owned
      medium_armor_quant = @campaign.campaign_items.find_by(item_id: medium_armor_id).quantity_owned
      raft_quant = @campaign.campaign_items.find_by(item_id: raft_id).quantity_owned

      expect(light_armor_quant).to eq(1)
      expect(medium_armor_quant).to eq(1)
      expect(raft_quant).to eq(1)
    end
  end
end
