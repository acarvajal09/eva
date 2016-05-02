require 'spec_helper'

describe Eva::Cli do

  describe 'Commands in Cli' do

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

end
