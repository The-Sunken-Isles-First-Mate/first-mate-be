require 'rails_helper'

RSpec.describe DndService do
  it 'can make API call to database' do
    query = DndService.call_db('classes')
    result = query.first

    expect(query).to be_an Hash
    expect(result).to be_a Array
    # check_hash_structure(result, :key_name, data_type)
  end

  it 'can make API call to database' do
    query = DndService.call_db('races')
    result = query.first
    
    expect(query).to be_an Hash
    expect(result).to be_a Array
    # check_hash_structure(result, :key_name, data_type)
  end
end