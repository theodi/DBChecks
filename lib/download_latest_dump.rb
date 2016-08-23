module DBChecks
  module Mongo
    def self.download_latest_dump
      require 'fog'
      require 'securerandom'
      require 'dotenv'

      Dotenv.load

      temp_key = SecureRandom.base64

      client = Fog::Storage.new({
        provider: 'Rackspace',
        rackspace_username: ENV['RACKSPACE_USER'],
        rackspace_api_key: ENV['RACKSPACE_KEY'],
        rackspace_region: :lon,
        rackspace_temp_url_key: temp_key
      })

      account = client.account
      account.meta_temp_url_key = temp_key
      account.save

      dir = client.directories.get('quirkafleeg-dumps')
      key = dir.files.last.key
      file = dir.files.get(key)

      FileUtils.mkdir_p 'dumps/'

      File.open "dumps/#{key}", 'w' do |f|
        f.write file.body
      end
    end
  end
end
