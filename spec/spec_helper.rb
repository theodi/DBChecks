require 'rake'
require 'mongo'
require_relative '../lib/mongo_tasks'

RSpec.configure do |config|
  config.before :all do
    Mongo::Logger.logger.level = ::Logger::FATAL

    unless ENV['SPEEDY']
      puts 'Preparing the ground'
      DBChecks::Mongo::download_latest_dump
      DBChecks::Mongo::nuke_db
      DBChecks::Mongo::restore_dump
    end
  end
end
