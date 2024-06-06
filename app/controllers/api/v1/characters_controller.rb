class Api::V1::CharactersController < ApplicationController
  def show
    character = Character.find(params[:id])
    render json: CharacterSerializer.new(character)
  end

  #<ActionController::Parameters {"json"=>"{\"character\":{\"name\":\"Test Character 52353\",\"dnd_race\":\"Dragonborn\",\"dnd_class\":\"Barbarian\",\"user_id\":\"4\"}}", "file"=>#<ActionDispatch::Http::UploadedFile:0x000000010f910dd8 @tempfile=#<Tempfile:/var/folders/zs/br8ptm7d7ks3v4mdr6ctx1c40000gn/T/RackMultipart20240605-23944-jil1f2.png>, @content_type="image/png", @original_filename="RackMultipart20240605-23924-u6t3it.png", @headers="Content-Disposition: form-data; name=\"file\"; filename=\"RackMultipart20240605-23924-u6t3it.png\"\r\nContent-Type: image/png\r\n">, "controller"=>"api/v1/characters", "action"=>"create"} permitted: false>
  #<ActionController::Parameters {"character"=>{"name"=>"Cap'n Clirrk", "user_id"=>380, "dnd_race"=>"Human", "dnd_class"=>"Bard"}, "controller"=>"api/v1/characters", "action"=>"create"} permitted: false>
  def create
    if params[:json]
      char_params = JSON.parse(params[:json], symbolize_names: true)
      character_data = char_params[:character]
      image = params[:file]

      character = Character.new(character_data)
      character.save!
      character.character_image.attach(io: image.tempfile, filename: image.original_filename)

      render json: CharacterSerializer.new(character), status: :created
    else
      character = Character.new(character_params)
      character.save!

      render json: CharacterSerializer.new(character), status: :created
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
