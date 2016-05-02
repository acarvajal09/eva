require 'spec_helper'

describe Eva::Direction do
  before(:each) do
    @direction = Eva::Direction.new
  end

  before(:all) do
    @directions = Eva::Direction::DIRECTIONS
  end

  it 'first position will be zero' do
    expect(@direction.current).to be 0
  end

  describe '.move_right!' do

    it 'should move to EAST when current direction is NORTH' do
      @direction.place!('NORTH')
      @direction.move_right!
      expect(@directions[@direction.current]).to eq 'EAST'
    end

    it 'should move to SOUTH when current direction is EAST' do
      @direction.place!('EAST')
      @direction.move_right!
      expect(@directions[@direction.current]).to eq 'SOUTH'
    end

    it 'should move to WEST when current direction is SOUTH' do
      @direction.place!('SOUTH')
      @direction.move_right!
      expect(@directions[@direction.current]).to eq 'WEST'
    end

    it 'should move to NORTH when current direction is WEST' do
      @direction.place!('WEST')
      @direction.move_right!
      expect(@directions[@direction.current]).to eq 'NORTH'
    end

  end

  describe '.move_left!' do

    it 'should move to WEST when current direction is NORTH' do
      @direction.place!('NORTH')
      @direction.move_left!
      expect(@directions[@direction.current]).to eq 'WEST'
    end

    it 'should move to NORTH when current direction is EAST' do
      @direction.place!('EAST')
      @direction.move_left!
      expect(@directions[@direction.current]).to eq 'NORTH'
    end

    it 'should move to EAST when current direction is SOUTH' do
      @direction.place!('SOUTH')
      @direction.move_left!
      expect(@directions[@direction.current]).to eq 'EAST'
    end

    it 'should move to NORTH when current direction is WEST' do
      @direction.place!('WEST')
      @direction.move_left!
      expect(@directions[@direction.current]).to eq 'SOUTH'
    end

  end

  describe '.place!' do

    it 'should place to NORTH' do
      @direction.place!('NORTH')
      expect(@directions[@direction.current]).to eq 'NORTH'
    end

    it 'should place to EAST' do
      @direction.place!('EAST')
      expect(@directions[@direction.current]).to eq 'EAST'
    end

    it 'should place to SOUTH' do
      @direction.place!('SOUTH')
      expect(@directions[@direction.current]).to eq 'SOUTH'
    end

    it 'should place to WEST' do
      @direction.place!('WEST')
      expect(@directions[@direction.current]).to eq 'WEST'
    end

  end

end
