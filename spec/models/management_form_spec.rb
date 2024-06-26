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

  it "will only update the management_form if the sum of resource fields is less than number of villagers" do
    @campaign1 = create(:campaign)
    @management_form = ManagementForm.create(campaign: @campaign1, week: 0)

    expect(@campaign1.villagers).to eq(120)

    @management_form.update!(cloth: 100)
    expect(@management_form.cloth).to eq(100)
    expect(@management_form.errors[:base]).to be_empty

    @management_form.update(animal_products: 100, cloth: 100)
    expect(@management_form.errors[:base]).to eq(["You cannot allocate more than 120 villagers to collect resources. Please try again."])
  end

  it "will only update the management_form if a resource_field has a value that is 10 or 0" do
    @campaign1 = create(:campaign)
    @management_form = ManagementForm.create(campaign: @campaign1, week: 0)

    @management_form.update!(cloth: 100)
    expect(@management_form.cloth).to eq(100)
    expect(@management_form.errors[:base]).to be_empty

    @management_form.update!(cloth: 0)
    expect(@management_form.cloth).to eq(0)
    expect(@management_form.errors[:base]).to be_empty

    @management_form.update(cloth: 3)
    expect(@management_form.errors[:base]).to eq(["Villagers must be dispatched in groups of 10. Please try again."])
  end

  it "will only update the management_form if the sum of all 'buiding' items is less than or equal to 1" do
    @campaign1 = create(:campaign, farmed_goods: 20, wood: 20, stone: 20)
    @management_form = ManagementForm.create(campaign: @campaign1, week: 0)

    @management_form.update!(cabin: 1)
    expect(@management_form.cabin).to eq(1)
    expect(@management_form.errors[:base]).to be_empty

    # adding an additional building to update when one already has a value
    @management_form.update(magical_defenses: 1)
    expect(@management_form.errors[:base]).to eq(["You cannot commission more than one building per week. Please try again."])

    @management_form.delete
    # adding more than one building to a single field
    @management_form = ManagementForm.create(campaign: @campaign1, week: 0)

    @management_form.update(magical_defenses: 2)
    expect(@management_form.errors[:base]).to eq(["You cannot commission more than one building per week. Please try again."])
  end

  it "will only update the management_form if the total number of each resource_cost field from each item is less than the respective campaign resource value" do
    # happy path for creating an item with enough resources
    @campaign1 = create(:campaign, animal_products: 2, metal: 2, week: 2)
    @management_form1 = ManagementForm.create(campaign: @campaign1, week: 2)

    @management_form1.update!(light_armor: 1)
    expect(@management_form1.light_armor).to eq(1)
    expect(@management_form1.errors[:base]).to be_empty

    # sad path for not having enough resources for one item
    @campaign2 = create(:campaign)
    @management_form2 = ManagementForm.create(campaign: @campaign2, week: 0)

    @management_form2.update(light_armor: 1)
    expect(@management_form2.errors[:base]).to eq(["You do not have the resources to build that item. Please try again."])
    
    # sad path for having enough resources for either item but not both
    @campaign3 = create(:campaign, animal_products: 2, metal: 2, week: 2)
    @management_form3 = ManagementForm.create(campaign: @campaign3, week: 2)

    @management_form3.update(light_armor: 1, medium_armor: 1)
    expect(@management_form3.errors[:base]).to eq(["You do not have the resources to build that item. Please try again."])
  end
end
