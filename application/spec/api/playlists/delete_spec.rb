require 'spec_helper'

describe 'DELETE /api/playlists' do
  before :all do
    @playlist = create(:playlist_with_songs)
    header('token', @playlist.user.token)
  end

  it 'should delete playlist' do
    delete "api/v1.0/playlists/#{@playlist.id}"
    expect(last_response.status).to eq(200)
    expect(Api::Models::Playlist.select_map(:id)).not_to include(@playlist.id)
    expect(Api::Models::PlaylistSong.select_map(:playlist_id)).not_to include(@playlist.id)
  end

  it 'should return not found' do
    delete "api/v1.0/playlists/#{Api::Models::Playlist.max(:id) + 1}"
    expect(last_response.status).to eq(404)
  end
end
