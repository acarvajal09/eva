require 'logger'

class EvaLogger

  # This method create a log
  #
  # = Example
  #
  # EvaLogger.log
  def self.log
    if @logger.nil?
      @logger = Logger.new 'log/eva.log'
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
    end
    $log = @logger
  end

end
