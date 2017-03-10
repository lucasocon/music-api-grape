require 'spec_helper'

describe 'DELETE /api/artists' do
  before :all do
    @a1 = create :artist_with_albums
    @a2 = create :artist
  end

  it 'should delete artist' do
    delete "api/v1.0/artists/#{@a2.id}"
    expect(last_response.status).to eq(200)
  end

  it 'should return not found' do
    delete "api/v1.0/artists/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
