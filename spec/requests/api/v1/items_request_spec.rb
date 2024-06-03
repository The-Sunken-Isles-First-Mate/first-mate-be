require 'rails_helper'

RSpec.describe "Items API" do
  before(:each) do
    @item1 = create(:item)
    @item2 = create(:item)
    @campaign1 = create(:campaign)
    @campaign1.items << [@item1, @item2]
  end

  describe "Item Show" do
    it "returns all item attributes for a specific item" do
      get "/api/v1/items/#{@item1.id}"

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:animal_products_cost)
      expect(item[:attributes][:animal_products_cost]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:cloth_cost)
      expect(item[:attributes][:cloth_cost]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:farmed_goods_cost)
      expect(item[:attributes][:farmed_goods_cost]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:food_cost)
      expect(item[:attributes][:food_cost]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:foraged_goods_cost)
      expect(item[:attributes][:foraged_goods_cost]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:metal_cost)
      expect(item[:attributes][:metal_cost]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:stone_cost)
      expect(item[:attributes][:stone_cost]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:wood_cost)
      expect(item[:attributes][:wood_cost]).to be_an(Integer)
    end

    it "returns a 404 status and error message when an invalid item id is passed in" do 
      get "/api/v1/items/123123" 

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Item with 'id'=123123")
    end
  end

  describe "item index" do
    describe "happy path" do
      it "returns all items and their attributes" do
        create_list(:item, 3)

        get "/api/v1/items"
  
        items = JSON.parse(response.body, symbolize_names: true)[:data]
  
        expect(response).to be_successful
        expect(response.status).to eq(200)
  
        expect(items).to be_an(Array)
        expect(items.count).to eq(5)

        
        items.each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_a(String)
    
          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)
    
          expect(item[:attributes]).to have_key(:animal_products_cost)
          expect(item[:attributes][:animal_products_cost]).to be_an(Integer)
    
          expect(item[:attributes]).to have_key(:cloth_cost)
          expect(item[:attributes][:cloth_cost]).to be_an(Integer)
    
          expect(item[:attributes]).to have_key(:farmed_goods_cost)
          expect(item[:attributes][:farmed_goods_cost]).to be_an(Integer)
    
          expect(item[:attributes]).to have_key(:food_cost)
          expect(item[:attributes][:food_cost]).to be_an(Integer)
    
          expect(item[:attributes]).to have_key(:foraged_goods_cost)
          expect(item[:attributes][:foraged_goods_cost]).to be_an(Integer)
    
          expect(item[:attributes]).to have_key(:metal_cost)
          expect(item[:attributes][:metal_cost]).to be_an(Integer)
    
          expect(item[:attributes]).to have_key(:stone_cost)
          expect(item[:attributes][:stone_cost]).to be_an(Integer)
    
          expect(item[:attributes]).to have_key(:wood_cost)
          expect(item[:attributes][:wood_cost]).to be_an(Integer)
        end
      end
    end
  end
end