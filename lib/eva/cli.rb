module Eva
  class Cli

    # This method start the cli for Eva
    #
    # = Example
    #
    # Eva::Cli.start || Eva::Cli.start('assets/commands.csv')
    def self.start(file=nil)
      file ||= file
      runner = Runner.new

      if file.nil?
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
      else
        if File.file?(file) && File.extname(file).eql?('.csv')
          File.readlines(file).each do |line|
            runner.do(line)
          end
          puts "Eva was moved!"
        else
          puts "Invalid file: #{file}"
        end
      end
    end

  end
end
