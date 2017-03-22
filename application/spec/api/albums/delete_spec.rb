require 'spec_helper'

describe 'DELETE /api/albums' do
  before :all do
    @user = create :user
    header('token', @user.token)
    @artist1 = create :artist_with_albums
    @artist2 = create :artist_with_albums
    @album = @artist1.albums.sample
  end

  it 'should delete album' do
    songs_ids = @album.songs.map(&:id)
    delete "api/v1.0/albums/#{@album.id}"
    expect(last_response.status).to eq(200)
    expect(Api::Models::Album.select_map(:artist_id)).not_to include(@album.id)
    expect(Api::Models::Song.select_map(:id)).not_to include(songs_ids)
  end

  it 'should return not found' do
    delete "api/v1.0/albums/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
