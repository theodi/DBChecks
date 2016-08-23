describe 'Test Mongo Backups' do
  it 'gets the latest file' do
    today = (DateTime.now).strftime('%Y-%m-%d')
    expect(Dir.entries('dumps/').last).to eq "mongo-#{today}.tbz"
  end

  context 'restores a database' do
    it 'has collections' do
      client = Mongo::Client.new(['127.0.0.1:27017'], database: 'govuk_content_publisher')
      db = client.database
      expect(db.collections.count).to be >= 10
    end
  end
end
