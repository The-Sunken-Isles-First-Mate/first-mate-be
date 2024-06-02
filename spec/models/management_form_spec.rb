require 'rails_helper'

RSpec.describe ManagementForm, type: :model do
  describe 'relationships' do
    it { should belong_to(:campaign) }
  end

  describe 'validations' do
    it {should validate_presence_of(:campaign_id)}
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
    it {should validate_presence_of(:light_armor)}
    it {should validate_presence_of(:medium_armor)}
    it {should validate_presence_of(:heavy_armor)}
    it {should validate_presence_of(:simple_weapon)}
    it {should validate_presence_of(:martial_weapon)}
    it {should validate_presence_of(:ammunition)}
    it {should validate_presence_of(:adventuring_supplies)}
    it {should validate_presence_of(:assassins_blood)}
    it {should validate_presence_of(:malice)}
    it {should validate_presence_of(:midnight_tears)}
    it {should validate_presence_of(:serpent_venom)}
    it {should validate_presence_of(:truth_serum)}
    it {should validate_presence_of(:oil_of_slipperiness)}
    it {should validate_presence_of(:potion_of_climbing)}
    it {should validate_presence_of(:potion_of_healing)}
    it {should validate_presence_of(:potion_of_water_breathing)}
    it {should validate_presence_of(:barge)}
    it {should validate_presence_of(:coracle)}
    it {should validate_presence_of(:double_hulled_sailing_canoe)}
    it {should validate_presence_of(:keelboat)}
    it {should validate_presence_of(:raft)}
    it {should validate_presence_of(:single_hulled_sailing_canoe)}
    it {should validate_presence_of(:ballista)}
    it {should validate_presence_of(:cabin)}
    it {should validate_presence_of(:magical_defenses)}
    it {should validate_presence_of(:storage)}

    it {should validate_numericality_of(:campaign_id)}
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
    it {should validate_numericality_of(:light_armor)}
    it {should validate_numericality_of(:medium_armor)}
    it {should validate_numericality_of(:heavy_armor)}
    it {should validate_numericality_of(:simple_weapon)}
    it {should validate_numericality_of(:martial_weapon)}
    it {should validate_numericality_of(:ammunition)}
    it {should validate_numericality_of(:adventuring_supplies)}
    it {should validate_numericality_of(:assassins_blood)}
    it {should validate_numericality_of(:malice)}
    it {should validate_numericality_of(:midnight_tears)}
    it {should validate_numericality_of(:serpent_venom)}
    it {should validate_numericality_of(:truth_serum)}
    it {should validate_numericality_of(:oil_of_slipperiness)}
    it {should validate_numericality_of(:potion_of_climbing)}
    it {should validate_numericality_of(:potion_of_healing)}
    it {should validate_numericality_of(:potion_of_water_breathing)}
    it {should validate_numericality_of(:barge)}
    it {should validate_numericality_of(:coracle)}
    it {should validate_numericality_of(:double_hulled_sailing_canoe)}
    it {should validate_numericality_of(:keelboat)}
    it {should validate_numericality_of(:raft)}
    it {should validate_numericality_of(:single_hulled_sailing_canoe)}
    it {should validate_numericality_of(:ballista)}
    it {should validate_numericality_of(:cabin)}
    it {should validate_numericality_of(:magical_defenses)}
    it {should validate_numericality_of(:storage)}
  end

  it 'exists and has attributes' do
    form = create(:management_form)

    expect(form).to be_a ManagementForm
  end
end
