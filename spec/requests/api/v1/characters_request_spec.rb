require 'rails_helper'

RSpec.describe "Characters API" do
  before(:each) do
    @character1 = create(:character)
  end

  describe "Character Show" do
    it "returns all character attributes for a specific character" do
      get "/api/v1/characters/#{@character1.id}"

      character = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(character).to have_key(:id)
      expect(character[:id]).to be_an(String)

      expect(character[:attributes]).to have_key(:name)
      expect(character[:attributes][:name]).to be_a(String)

      # expect(character[:attributes]).to have_key(:user_id)
      # expect(character[:attributes][:user_id]).to be_a(String)
      
      expect(character[:attributes]).to have_key(:dnd_race)
      expect(character[:attributes][:dnd_race]).to be_a(String)
      
      expect(character[:attributes]).to have_key(:dnd_class)
      expect(character[:attributes][:dnd_class]).to be_a(String)
    end

    it "returns a 404 status and error message when an invalid character id is passed in" do 
      get "/api/v1/characters/123123" 

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Character with 'id'=123123")
    end
  end
end