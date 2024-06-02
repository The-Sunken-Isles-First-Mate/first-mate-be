class CharacterSerializer
  include JSONAPI::Serializer
  attributes :name, 
             :user_id,
             :dnd_race,
             :dnd_class,
             :image_url
end