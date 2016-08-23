describe 'Test Mongo Backups' do
  it 'gets the latest file' do
    today = (DateTime.now).strftime('%Y-%m-%d')
    expect(Dir.entries('dumps/').last).to eq "mongo-#{today}.tbz"
  end
end
