require 'spec_helper'

describe Eva::Table do
  before(:all) do
    @table = Eva::Table.new(5,5)
  end

  it 'should create a table with 5 width' do
    expect(@table.width).to be 5
  end

  it 'should create a table with 5 height' do
    expect(@table.height).to be 5
  end

  it 'should create a table with x value 0' do
    expect(@table.x).to be 0
  end

  it 'should create a table with y value 0' do
    expect(@table.y).to be 0
  end

end
