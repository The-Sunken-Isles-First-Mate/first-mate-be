require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'relationships' do

  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
end