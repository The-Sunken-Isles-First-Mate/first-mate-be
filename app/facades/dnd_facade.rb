class DndFacade 
  def self.classes
    response = DndService.call_db('classes')
    response[:results].map { |r| DndClass.new(r) }
  end

  def self.races
    response = DndService.call_db('races')
    response[:results].map { |r| DndRace.new(r) }
  end
end