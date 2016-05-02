require 'spec_helper'

describe Eva::Command do
  before(:each) do
    @command = Eva::Command.new
  end

  describe 'invalid command' do

    it 'should return false when no commands' do
      cmd = ' '
      expect(@command.valid?(cmd)).to be_falsey
      expect(@command.error).to eq @command.invalid_command_message!('Blank command')
    end

    it 'should return false when command is not in white list' do
      cmd = 'FOO'
      expect(@command.valid?(cmd)).to be_falsey
      expect(@command.error).to eq @command.invalid_command_message!(cmd)
    end

  end

  describe 'PLACE' do

    describe 'invalid command' do

      it 'should return false when PLACE with no arguments' do
        cmd = 'PLACE'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

      it 'should return false when PLACE with less arguments' do
        cmd = 'PLACE 1,2'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

      it 'should return false when PLACE with more arguments' do
        cmd = 'PLACE 1,2,NORTH,3'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

      it 'should return false when PLACE with spaces after commas' do
        cmd = 'PLACE 1, 2, NORTH'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

      it 'should return false when PLACE with spaces before commas' do
        cmd = 'PLACE 1 ,2 ,NORTH'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

      it 'should return false when PLACE with invalid direction' do
        cmd = 'PLACE 1,2,FOO'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

      it 'should return false when PLACE with invalid X number' do
        cmd = 'PLACE -1,2,NORTH'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

      it 'should return false when PLACE with invalid Y number' do
        cmd = 'PLACE 1,-2,NORTH'
        expect(@command.valid?(cmd)).to be_falsey
        expect(@command.error).to eq @command.invalid_command_message!(cmd)
      end

    end

    describe 'valid command' do

      it 'should return true when PLACE with valid number' do
        cmd = 'PLACE 1,2,NORTH'
        expect(@command.valid?(cmd)).to be_truthy
        expect(@command.error).to be_nil
        expect(@command.command).to eq('PLACE')
        expect(@command.arguments).to eq({x: 1, y: 2, direction: 'NORTH'})
        expect(@command.full_command).to eq(cmd)
      end

    end

  end

  describe 'MOVE, RIGHT, LEFT, REPORT' do

    describe 'invalid command' do

      it 'should return false when command with arguments' do
        ['MOVE', 'RIGHT', 'LEFT', 'REPORT'].each do |cmd|
          cmd = "#{cmd} X"
          expect(@command.valid?(cmd)).to be_falsey
          expect(@command.error).to eq @command.invalid_command_message!(cmd)
        end
      end

    end

    describe 'valid command' do

      it 'should return true when MOVE' do
        ['MOVE', 'RIGHT', 'LEFT', 'REPORT'].each do |cmd|
          expect(@command.valid?(cmd)).to be_truthy
          expect(@command.error).to be_nil
          expect(@command.command).to eq(cmd)
          expect(@command.arguments).to eq({x: nil, y: nil, direction: nil})
          expect(@command.full_command).to eq(cmd)
        end

      end

    end

  end

end
