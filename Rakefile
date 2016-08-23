require_relative 'lib/download_latest_dump'

desc 'Download the latest backup'
namespace :dumps do
  namespace :download do
    task :latest do
      DBChecks::Mongo::download_latest_dump
    end
  end
end
