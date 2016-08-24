require 'rake'
require 'mongo'
require_relative '../lib/mongo_tasks'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

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
