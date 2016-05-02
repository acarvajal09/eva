module Eva
  class Cli

    # This method start the cli for Eva
    #
    # = Example
    #
    # Eva::Cli.start
    def self.start
      runner = Runner.new
      prompt = '> '
      print prompt

      while user_input = gets.chomp # loop while getting user input
        case user_input
        when 'EXIT'
          break # No more commands
        when 'exit'
          break # No more commands
        else
          runner.do(user_input)
          print prompt # print the prompt, so the user knows to re-enter input
        end
      end
    end

  end
end
