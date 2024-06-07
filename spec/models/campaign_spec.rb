require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'relationships' do
    it { should have_many(:user_campaigns) }
    it { should have_many(:users).through(:user_campaigns) }
    it { should have_many(:characters).through(:user_campaigns) }
    it { should have_many(:campaign_items) }
    it { should have_many(:items).through(:campaign_items) }
    it { should have_many(:management_forms) }
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

  it "creates campaign_items from the Items in the seed database when a campaign is created" do
    @campaign1 = Campaign.create(name: "Test Campaign")

    expect(@campaign1.items.count).to eq(27)

    @campaign1.items.each do |item|
      expect(item).to be_an(Item)
      expect(item.name).to be_an(String)
    end
  end

  it "creates a management_form campaign is created" do
    expect(ManagementForm.all.count).to eq 0

    @campaign1 = Campaign.create(name: "Test Campaign")

    expect(ManagementForm.all.count).to eq 1

    expect(@campaign1.management_forms.first).to be_a(ManagementForm)
    expect(@campaign1.management_forms.first.week).to eq(0)
  end
end
