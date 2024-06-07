class Api::V1::Campaigns::CharactersController < ApplicationController
  def index
    campaign = Campaign.find(params[:id])
    characters = campaign.characters
    characters.map do |character|
      character.character_image
    end
    render json: CharacterSerializer.new(characters)
  end
end
