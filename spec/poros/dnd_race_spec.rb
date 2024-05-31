require 'rails_helper'

RSpec.describe DndRace do
  it 'exists and has attributes' do
    c = DndRace.new({ name: "Elf" })
    expect(c).to be_a(DndRace)

    expect(c.name).to eq("Elf")
  end
end