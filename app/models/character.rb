class Character < ApplicationRecord
  belongs_to :user
 
  validates_presence_of :name, :dnd_race, :dnd_class
end