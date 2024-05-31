require 'rails_helper'

RSpec.describe DndFacade do
  # VCR.use_cassette('cassette_name.yml') do
    it 'get class info' do
      result = DndFacade.classes	
      r      = result.first
      
      expect(result).to be_an(Array)
      expect(r).to be_a(DndClass)
      expect(r.name).to be_an(String)
    end
    # end

  # VCR.use_cassette('cassette_name.yml') do
    it 'get race info' do
      result = DndFacade.races	
      r      = result.first
      
      expect(result).to be_an(Array)
      expect(r).to be_a(DndRace)
      expect(r.name).to be_an(String)
    end
  # end
end