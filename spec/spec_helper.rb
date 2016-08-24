require 'rake'
require 'mongo'
require 'mongo_jobs'

RSpec.configure do |config|
  config.before :all do
    Mongo::Logger.logger.level = ::Logger::FATAL

    unless ENV['SPEEDY']
      puts 'Preparing the ground'
      MongoJobs::download_latest_dump 'quirkafleeg-dumps'
      MongoJobs::nuke_db 'govuk_content_publisher'
      MongoJobs::restore_dump
    end
  end
end
