describe 'Test Mongo Backups' do
  it 'gets the latest file' do
    today = (DateTime.now).strftime('%Y-%m-%d')
    expect(Dir.entries('dumps/').last).to eq "mongo-#{today}.tbz"
  end

  context 'restores a database' do
    subject(:client) {
      Mongo::Client.new(['127.0.0.1:27017'], database: 'govuk_content_publisher')
    }

    subject(:db) {
      client.database
    }

    subject(:collections) {
      db.collections
    }

    it 'has collections' do
      expect(collections.count).to be >= 10
    end

    it 'has the right collections' do
      expect(collections.first.name).to eq 'artefacts'
      expect(collections.last.name).to eq 'publisher_users'
    end
  end
end
