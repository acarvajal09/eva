require 'simplecov'
SimpleCov.start do
  SimpleCov.add_filter do |src_file|
    File.basename(src_file.filename) == 'eva_logger.rb'
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'eva'
