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
    puts 'Preparing the ground'
    DBChecks::Mongo::download_latest_dump
    wait
    DBChecks::Mongo::nuke_db
    wait
    DBChecks::Mongo::restore_dump
    wait
  end
end

def wait
  print 'Sleeping because some fucking mysterious asynchronous shit is happening... '
  sleep 5
  puts 'done'
end
