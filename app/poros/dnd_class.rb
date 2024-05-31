class DndClass 
  attr_reader :name
  
  def initialize(data)
    @name = data[:name]
  end
end