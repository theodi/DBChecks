describe 'Test Quirkafleeg Mongo Backups' do
  it 'gets the latest file' do
    today = (DateTime.now).strftime('%Y-%m-%d')
    expect(Dir.entries('dumps/').last).to eq "mongo-#{today}.tbz"
  end

  context 'restore a database' do
    subject(:client) {
      Mongo::Client.new(['127.0.0.1:27017'], database: 'govuk_content_publisher')
    }
    subject(:db) { client.database }
    subject(:collections) { db.collections }

    context 'inspect collections' do
      it 'has collections' do
        expect(collections.count).to be >= 10
      end

      it 'has the right collections' do
        expect(collections.map { |c| c.name }.sort.first).to eq 'artefacts'
        expect(collections.map { |c| c.name }.sort.last).to eq 'users'
      end

      context 'its collections are the right size' do
        it 'has enough panopticon users' do
          expect(client[:panopticon_users].count).to be >= 91
        end

        it 'has enough artefacts' do
          expect(client[:artefacts].count).to be >= 1900
        end
      end

      context 'its collections have the right content' do
        it 'edition has the right words' do
          words = db[:editions].find( {
            slug: 'sam-pikesley',
            version_number: 4
          } ).entries.first[:description]

          expect(words).to match /Vim is the One True Editor/
        end
      end
    end
  end
end
