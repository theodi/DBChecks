require 'mongo_jobs'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

desc 'Download the latest backup'
namespace :dumps do
  namespace :download do
    task :latest do
      MongoJobs::download_latest_dump 'quirkafleeg-dumps'
    end
  end
end

task :default => [:spec]
