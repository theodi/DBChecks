require_relative 'lib/mongo_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

desc 'Download the latest backup'
namespace :dumps do
  namespace :download do
    task :latest do
      DBChecks::Mongo::download_latest_dump
    end
  end
end

task :default => [:spec]
