require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = create(:user, uid: 'abc123', username: 'coolusername', token: 'abcdefghjk124abc')
  end
  describe 'relationships' do
    # it {should have_many(:user_campaigns) }
    # it {should have_many(:campaigns).through(:user_campaigns) }
    # it {should have_many(:characters) }
  end

  describe 'validations' do
    it {should validate_presence_of(:uid)}
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:token)}

    it {should validate_uniqueness_of(:uid)}
  end

  it 'exists and has attributes' do
    expect(@user1).to be_a User
    expect(@user1.uid).to eq('abc123')
    expect(@user1.username).to eq('coolusername')
    expect(@user1.token).to eq('abcdefghjk124abc')
  end
end
