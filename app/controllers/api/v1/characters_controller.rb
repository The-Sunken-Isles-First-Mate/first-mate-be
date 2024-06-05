class Api::V1::CharactersController < ApplicationController 
  def show
    character = Character.find(params[:id])
    render json: CharacterSerializer.new(character)
  end

  def create
    # character = Character.new(character_params)
    # character.save!
    # character.character_image.attach(params[:character][:character_image])
    # render json: CharacterSerializer.new(character), status: 201
    require 'pry'; binding.pry
    @character = Character.new(character_params)

    if @character.save
      if params[:character][:character_image].present?
        file = params[:character][:character_image]
        @character.character_image.attach(io: file[:tempfile], filename: file[:original_filename], content_type: file[:content_type])
      end
      render json: @character.as_json.merge(character_image_details: @character.character_image_details), status: :created
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  private
  def character_params
    params.require(:character)
          .permit(:name, 
                  :user_id, 
                  :dnd_race, 
                  :dnd_class, 
                  :image_url,
                  :character_image)
  end
end