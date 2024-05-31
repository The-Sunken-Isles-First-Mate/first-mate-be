class DndService					
  def self.call_db(url)		
    response = connection.get(url) do |request| 			
    end		
    JSON.parse(response.body, symbolize_names: true)		
  end		
      
  private		
      
  def self.connection		
    Faraday.new('https://www.dnd5eapi.co/api/')		
  end
end