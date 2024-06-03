class Api::V1::Campaigns::CharactersController < ApplicationController 
  def index
    campaign = Campaign.find(params[:id])
    characters = campaign.characters
    render json: CharacterSerializer.new(characters)
  end
end