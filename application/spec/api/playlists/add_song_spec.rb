require 'spec_helper'

describe 'PUT /api/playlists/:id/songs' do
  before :all do
    @playlist = create :playlist_with_songs
    @artist = create :artist_with_albums
  end

  it 'should add song to playlist' do
    put("api/v1.0/playlists/#{@playlist.id}/songs", {song_id: @artist.songs.order{RANDOM{}}.first.id})
    expect(last_response.status).to eq(200)
  end

  it 'should return not found' do
    put("api/v1.0/playlists/#{@playlist.id}/songs", {})
    body = response_body
    expect(last_response.status).to eq(404)
    expect(body.keys).to eq([:error])
  end

  it 'should return custom message to duplicate songs' do
    put("api/v1.0/playlists/#{@playlist.id}/songs", {song_id: @playlist.songs.sample.id})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:error])
    expect(body[:error]).to eq('This song was already added to this playlist.')
  end
end
