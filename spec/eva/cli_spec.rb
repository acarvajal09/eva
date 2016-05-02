require 'spec_helper'

describe Eva::Cli do

  describe 'Interactive commands' do

    it 'should not kill Eva when valid commands' do
      cmds = ['PLACE 0,0,NORTH', 'MOVE', 'RIGHT','LEFT','REPORT']
      allow(Eva::Cli).to receive(:gets) do
        @counter ||= 0
        response = if @counter < cmds.size
                     cmds[@counter]
                   else
                     'exit'
                   end
        @counter += 1
        response
      end
      expect {Eva::Cli.start}.not_to output("Eva almost die!\n").to_stdout
    end

    it 'should not kill Eva when valid commands' do
      cmds = ['PLACE 0,0,NORTH', 'MOVE', 'RIGHT','LEFT','REPORT']
      allow(Eva::Cli).to receive(:gets) do
        @counter ||= 0
        response = if @counter < cmds.size
                     cmds[@counter]
                   else
                     'EXIT'
                   end
        @counter += 1
        response
      end
      expect {Eva::Cli.start}.not_to output("Eva almost die!\n").to_stdout
    end

  end

  describe 'Commands from file' do

    it 'should run valid commands' do
      expected = "0,1,NORTH\n0,0,WEST\n3,3,NORTH\nEva was moved!\n"
      expect {Eva::Cli.start("assets/commands.csv")}.to output(expected).to_stdout
    end

    it 'should not run when file doesnt exists' do
      file = "assets/foo.csv"
      expect {Eva::Cli.start(file)}.to output("Invalid file: #{file}\n").to_stdout
    end

    it 'should not run when file is not .csv' do
      file = "assets/commands.txt"
      expect {Eva::Cli.start(file)}.to output("Invalid file: #{file}\n").to_stdout
    end

  end

end
