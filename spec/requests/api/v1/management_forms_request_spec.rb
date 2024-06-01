require 'rails_helper'

RSpec.describe "ManagementForms API" do
  before(:each) do
    @campaign1 = create(:campaign)
    @management_form1 = create(:management_form, campaign_id: @campaign1.id, week: @campaign1.week)
  end

  describe "ManagementForm Show" do
    it "returns all ManagementForm attributes for a specific management form" do
      valid_attr = {
        management_form: {
          campaign_id: @campaign1.id,
          week: @campaign1.week
        }
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      get "/api/v1/management_form", params: valid_attr, headers: headers

      form = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(form).to have_key(:id)
      expect(form[:id]).to be_an(String)

      expect(form).to have_key(:type)
      expect(form[:type]).to eq('management_form')

      expect(form[:attributes]).to have_key(:week)
      expect(form[:attributes][:week]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:animal_products)
      expect(form[:attributes][:animal_products]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:cloth)
      expect(form[:attributes][:cloth]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:farmed_goods)
      expect(form[:attributes][:farmed_goods]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:food)
      expect(form[:attributes][:food]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:foraged_goods)
      expect(form[:attributes][:foraged_goods]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:metal)
      expect(form[:attributes][:metal]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:monster_parts)
      expect(form[:attributes][:monster_parts]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:stone)
      expect(form[:attributes][:stone]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:wood)
      expect(form[:attributes][:wood]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:light_armor)
      expect(form[:attributes][:light_armor]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:medium_armor)
      expect(form[:attributes][:medium_armor]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:heavy_armor)
      expect(form[:attributes][:heavy_armor]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:simple_weapon)
      expect(form[:attributes][:simple_weapon]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:martial_weapon)
      expect(form[:attributes][:martial_weapon]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:ammunition)
      expect(form[:attributes][:ammunition]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:adventuring_supplies)
      expect(form[:attributes][:adventuring_supplies]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:assassins_blood)
      expect(form[:attributes][:assassins_blood]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:malice)
      expect(form[:attributes][:malice]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:midnight_tears)
      expect(form[:attributes][:midnight_tears]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:serpent_venom)
      expect(form[:attributes][:serpent_venom]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:truth_serum)
      expect(form[:attributes][:truth_serum]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:oil_of_slipperiness)
      expect(form[:attributes][:oil_of_slipperiness]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:potion_of_climbing)
      expect(form[:attributes][:potion_of_climbing]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:potion_of_healing)
      expect(form[:attributes][:potion_of_healing]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:potion_of_water_breathing)
      expect(form[:attributes][:potion_of_water_breathing]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:barge)
      expect(form[:attributes][:barge]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:coracle)
      expect(form[:attributes][:coracle]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:double_hulled_sailing_canoe)
      expect(form[:attributes][:double_hulled_sailing_canoe]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:keelboat)
      expect(form[:attributes][:keelboat]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:raft)
      expect(form[:attributes][:raft]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:single_hulled_sailing_canoe)
      expect(form[:attributes][:single_hulled_sailing_canoe]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:ballista)
      expect(form[:attributes][:ballista]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:cabin)
      expect(form[:attributes][:cabin]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:magical_defenses)
      expect(form[:attributes][:magical_defenses]).to be_an(Integer)

      expect(form[:attributes]).to have_key(:storage)
      expect(form[:attributes][:storage]).to be_an(Integer)

      expect(form[:relationships]).to have_key(:campaign)
      expect(form[:relationships][:campaign]).to be_an(Hash)

      expect(form[:relationships][:campaign][:data]).to have_key(:id)
      expect(form[:relationships][:campaign][:data][:id]).to be_an(String)
    end

    describe 'Sad Paths' do
      it "returns a 404 status and error message when an invalid campaign id or week is passed in" do
        invalid_attr = {
          management_form: {
            campaign_id: 123123,
            week: @campaign1.week
          }
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        get "/api/v1/management_form", params: invalid_attr, headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:status]).to eq("404")
        expect(data[:errors].first[:title]).to eq("Couldn't find Campaign with 'id'=123123")
      end

      it "returns a 400 status and error message when an invalid week is passed in" do
        invalid_attr = {
          management_form: {
            campaign_id: @campaign1.id,
            week: 99
          }
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        get "/api/v1/management_form", params: invalid_attr, headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:status]).to eq("400")
        expect(data[:errors].first[:title]).to eq("Week cannot be less than 0 or greater than the campaign week")
      end

      it "returns a 400 status and error message when no campaign id or no week is passed in" do
        invalid_attr = {
          management_form: {
            campaign_id: @campaign1.id
          }
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        get "/api/v1/management_form", params: invalid_attr, headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:status]).to eq("400")
        expect(data[:errors].first[:title]).to eq("Campaign ID or Week cannot be missing")
      end
    end
  end
end
