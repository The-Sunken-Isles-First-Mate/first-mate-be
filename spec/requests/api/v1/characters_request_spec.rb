require 'rails_helper'

RSpec.describe "Characters API" do
  before(:each) do
    @character1 = create(:character)
    @character2 = create(:character)
    @character3 = create(:character)
    @campaign1 = create(:campaign)
    @campaign1.characters << [@character1, @character2, @character3]
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

  describe "Character Create" do
    it "creates a new campaign record when passed the required attributes" do
      # @user1 = create(:user)
      character_params = ({ name: "Cap'n Clirrk",
                            # user_id: @user1.id,
                            dnd_race: "Human",
                            dnd_class: "Bard" })

      headers = {"CONTENT_TYPE" => "application/json"}
    
      post "/api/v1/characters", headers: headers, params: JSON.generate(character: character_params)
      created_character = Character.last
    
      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(created_character.name).to eq("Cap'n Clirrk")
      # expect(created_character.user).to eq(@user1)
      expect(created_character.dnd_race).to eq("Human")
      expect(created_character.dnd_class).to eq("Bard")
    end

    it "returns a 400 status and error message when missing any required attribute" do 
      character_params = ({ name: "Cap'n Clirrk",
                            # user_id: @user1.id,
                            dnd_class: "Bard" })

      headers = {"CONTENT_TYPE" => "application/json"}
    
      post "/api/v1/characters", headers: headers, params: JSON.generate(character: character_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:title]).to eq("Validation failed: Dnd race can't be blank")
    end
  end

  describe "Campaign Characters Index" do
    it "returns all characters and their attributes for a specific campaign" do
      get "/api/v1/campaigns/#{@campaign1.id}/characters"

      characters = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(characters).to be_an(Array)
      expect(characters.count).to eq(3)
      
      characters.each do |character|
        expect(character).to have_key(:id)
        expect(character[:id]).to be_a(String)
  
        expect(character[:attributes]).to have_key(:name)
        expect(character[:attributes][:name]).to be_a(String)
  
        # expect(character[:attributes]).to have_key(:user_id)
        # expect(character[:attributes][:user_id]).to be_an(String)
  
        expect(character[:attributes]).to have_key(:dnd_race)
        expect(character[:attributes][:dnd_race]).to be_a(String)
  
        expect(character[:attributes]).to have_key(:dnd_class)
        expect(character[:attributes][:dnd_class]).to be_a(String)

        expect(character[:attributes]).to have_key(:image_url)
      end
    end

    it "returns a 404 status and error message when an invalid campaign id is passed in" do 
      get "/api/v1/campaigns/123123/characters" 

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Campaign with 'id'=123123")
    end
  end
end