require 'spec_helper'

describe Eva::Runner do
  before(:each) do
    @runner = Eva::Runner.new
  end

  before(:all) do
    @directions = Eva::Direction::DIRECTIONS
  end

  it 'should not execute commands is Eva is not placed' do
    cmd = "MOVE"
    expect {@runner.do(cmd)}.to output("Eva is not placed\n").to_stdout
  end

  describe 'REPORT' do

    describe 'PLACE' do

      it 'should not place Eva outside x value in table' do
        cmd = "PLACE #{@runner.table.width},#{@runner.table.height-1},NORTH"
        expect {@runner.do(cmd)}.to output("Eva almost die!\n").to_stdout
      end

      it 'should not place Eva outside y value in table' do
        cmd = "PLACE #{@runner.table.width-1},#{@runner.table.height},NORTH"
        expect {@runner.do(cmd)}.to output("Eva almost die!\n").to_stdout
      end

      it 'should place Eva into valid position inside table' do
        limit_x = @runner.table.width - 1
        limit_y = @runner.table.height - 1
        (0..limit_x).to_a.each do |x|
          (0..limit_y).to_a.each do |y|
            @directions.each do |direction|
              cmd = "PLACE #{x},#{y},#{direction}"
              @runner.do(cmd)
              expect {@runner.do('REPORT')}.to output("#{x},#{y},#{direction}\n").to_stdout
            end
          end
        end
      end

    end

    describe 'MOVE' do

      it 'should move Eva to valid position inside table' do
        limit_x = @runner.table.width - 1
        limit_y = @runner.table.height - 1
        (0..limit_x).to_a.each do |x|
          (0..limit_y).to_a.each do |y|
            @directions.each do |direction|
              cmd = "PLACE #{x},#{y},#{direction}"
              @runner.do(cmd)
              cmd = 'MOVE'
              expected_output = nil
              expected_output2 = nil
              if y == limit_y && direction.eql?('NORTH')
                expected_output = "Eva almost die!\n"
              elsif x == limit_x && direction.eql?('EAST')
                expected_output = "Eva almost die!\n"
              elsif y == 0 && direction.eql?('SOUTH')
                expected_output = "Eva almost die!\n"
              elsif x == 0 && direction.eql?('WEST')
                expected_output = "Eva almost die!\n"
              else
                if direction.eql?('NORTH')
                  expected_output2 = "#{x},#{y+1},#{direction}\n"
                elsif direction.eql?('EAST')
                  expected_output2 = "#{x+1},#{y},#{direction}\n"
                elsif direction.eql?('SOUTH')
                  expected_output2 = "#{x},#{y-1},#{direction}\n"
                elsif direction.eql?('WEST')
                  expected_output2 = "#{x-1},#{y},#{direction}\n"
                end
              end
              unless expected_output.nil?
                expect {@runner.do(cmd)}.to output(expected_output).to_stdout
              end
              unless expected_output2.nil?
                @runner.do(cmd)
                expect {@runner.do('REPORT')}.to output(expected_output2).to_stdout
              end
            end
          end
        end
      end

      it 'should move Eva to valid position inside table when multiple commands' do
        ['PLACE 0,0,NORTH','MOVE'].each do |cmd|
          @runner.do(cmd)
        end
        expect {@runner.do('REPORT')}.to output("0,1,NORTH\n").to_stdout

        ['PLACE 0,0,NORTH','LEFT'].each do |cmd|
          @runner.do(cmd)
        end
        expect {@runner.do('REPORT')}.to output("0,0,WEST\n").to_stdout

        ['PLACE 1,2,EAST','MOVE','MOVE', 'LEFT', 'MOVE'].each do |cmd|
          @runner.do(cmd)
        end
        expect {@runner.do('REPORT')}.to output("3,3,NORTH\n").to_stdout
      end

    end

    describe 'RIGHT' do

      it 'should turn Eva to valid position inside table' do
        limit_x = @runner.table.width - 1
        limit_y = @runner.table.height - 1
        (0..limit_x).to_a.each do |x|
          (0..limit_y).to_a.each do |y|
            @directions.each do |direction|
              cmd = "PLACE #{x},#{y},#{direction}"
              @runner.do(cmd)
              cmd = 'RIGHT'
              if direction.eql?('NORTH')
                expected_output = "#{x},#{y},EAST\n"
              elsif direction.eql?('EAST')
                expected_output = "#{x},#{y},SOUTH\n"
              elsif direction.eql?('SOUTH')
                expected_output = "#{x},#{y},WEST\n"
              elsif direction.eql?('WEST')
                expected_output = "#{x},#{y},NORTH\n"
              end
              @runner.do(cmd)
              expect {@runner.do('REPORT')}.to output(expected_output).to_stdout
            end
          end
        end
      end

    end

    describe 'LEFT' do

      it 'should turn Eva to valid position inside table' do
        limit_x = @runner.table.width - 1
        limit_y = @runner.table.height - 1
        (0..limit_x).to_a.each do |x|
          (0..limit_y).to_a.each do |y|
            @directions.each do |direction|
              cmd = "PLACE #{x},#{y},#{direction}"
              @runner.do(cmd)
              cmd = 'LEFT'
              if direction.eql?('NORTH')
                expected_output = "#{x},#{y},WEST\n"
              elsif direction.eql?('EAST')
                expected_output = "#{x},#{y},NORTH\n"
              elsif direction.eql?('SOUTH')
                expected_output = "#{x},#{y},EAST\n"
              elsif direction.eql?('WEST')
                expected_output = "#{x},#{y},SOUTH\n"
              end
              @runner.do(cmd)
              expect {@runner.do('REPORT')}.to output(expected_output).to_stdout
            end
          end
        end
      end

    end

  end

end
