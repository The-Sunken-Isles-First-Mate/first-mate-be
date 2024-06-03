class Api::V1::CharactersController < ApplicationController 
  def show
    character = Character.find(params[:id])
    render json: CharacterSerializer.new(character)
  end

  def create
    character = Character.new(character_params)
    character.save!
    render json: CharacterSerializer.new(character), status: 201
  end

  def index
    campaign = Campaign.find(params[:campaign_id])
    characters = campaign.characters
    render json: CharacterSerializer.new(characters)
  end

  private
  def character_params
    params.require(:character)
          .permit(:name, 
                  :user_id, 
                  :dnd_race, 
                  :dnd_class, 
                  :image_url)
  end
end