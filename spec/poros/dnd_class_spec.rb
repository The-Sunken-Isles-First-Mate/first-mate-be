require 'rails_helper'

RSpec.describe DndClass do
  it 'exists and has attributes' do
    c = DndClass.new({ name: "Rogue" })
    expect(c).to be_a(DndClass)

    expect(c.name).to eq("Rogue")
  end
end