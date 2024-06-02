require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'relationships' do
    # it { should belong_to(:user) }

  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    # it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:dnd_race)}
    it {should validate_presence_of(:dnd_class)}
  end
end