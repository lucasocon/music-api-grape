require 'spec_helper'

describe 'DELETE /api/playlists/:id/songs' do
  before :all do
    @playlist = create :playlist_with_songs
    @other_playlist = create :playlist_with_songs
    @artist = create :artist_with_albums
    header('token', @playlist.user.token)
  end

  it 'should remove song to playlist' do
    delete("api/v1.0/playlists/#{@playlist.id}/songs", song_id: @playlist.songs.sample.id)
    expect(last_response.status).to eq(200)
  end

  it 'should return not found' do
    delete("api/v1.0/playlists/#{@playlist.id}/songs", song_id: Api::Models::Song.max(:id) + 1)
    body = response_body
    expect(last_response.status).to eq(404)
    expect(body.keys).to eq([:error])
  end

  it 'should return not permissions to add song' do
    delete("api/v1.0/playlists/#{@other_playlist.id}/songs", song_id: @artist.songs.order { RANDOM {} }.first.id)
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body[:error]).to eq('You have no permissions to remove a song from this playlist.')
  end
end
