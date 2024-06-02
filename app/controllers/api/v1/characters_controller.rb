class Api::V1::CharactersController < ApplicationController 
  def show
    character = Character.find(params[:id])
    render json: CharacterSerializer.new(character)
  end
end