require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many(:campaign_items) }
    it { should have_many(:campaigns).through(:campaign_items) }
  end
end