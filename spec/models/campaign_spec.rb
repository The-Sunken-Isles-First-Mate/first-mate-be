require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'relationships' do
    it { should have_many(:campaign_items) }
    it { should have_many(:items).through(:campaign_items) }

  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:week)}
    it {should validate_presence_of(:animal_products)}
    it {should validate_presence_of(:cloth)}
    it {should validate_presence_of(:farmed_goods)}
    it {should validate_presence_of(:food)}
    it {should validate_presence_of(:foraged_goods)}
    it {should validate_presence_of(:metal)}
    it {should validate_presence_of(:monster_parts)}
    it {should validate_presence_of(:stone)}
    it {should validate_presence_of(:wood)}
    it {should validate_presence_of(:villagers)}

    it {should validate_numericality_of(:week)}
    it {should validate_numericality_of(:animal_products)}
    it {should validate_numericality_of(:cloth)}
    it {should validate_numericality_of(:farmed_goods)}
    it {should validate_numericality_of(:food)}
    it {should validate_numericality_of(:foraged_goods)}
    it {should validate_numericality_of(:metal)}
    it {should validate_numericality_of(:monster_parts)}
    it {should validate_numericality_of(:stone)}
    it {should validate_numericality_of(:wood)}
    it {should validate_numericality_of(:villagers)}

  end
end