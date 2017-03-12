require 'spec_helper'

describe 'DELETE /api/artists' do
  before :all do
    @a1 = create :artist_with_albums
    @a2 = create :artist_with_albums
  end

  it 'should delete artist' do
    a2_album_ids = @a2.albums.map(&:id)
    delete "api/v1.0/artists/#{@a2.id}"
    expect(last_response.status).to eq(200)
    expect(Api::Models::Artist.select_map(:id)).not_to include(@a2.id)
    expect(Api::Models::Album.select_map(:artist_id)).not_to include(@a2.id)
    expect(Api::Models::Song.select_map(:album_id)).not_to include(a2_album_ids)
  end

  it 'should return not found' do
    delete "api/v1.0/artists/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
