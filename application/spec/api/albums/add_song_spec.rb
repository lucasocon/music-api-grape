require 'spec_helper'

describe 'PUT /api/albums/:id/songs' do
  before :all do
    @album = create :album_with_songs
    @artist = create :artist_with_albums
  end

  it 'should add song to album' do
    song_ids = @album.songs.map(&:id)
    not_included_song_id = Api::Models::Song.exclude(songs__id: song_ids).order{ RANDOM {} }.first.id
    put("api/v1.0/albums/#{@album.id}/songs",
        song_id: not_included_song_id)

    expect(last_response.status).to eq(200)
  end

  it 'should return not found' do
    put("api/v1.0/albums/#{@album.id}/songs", {})
    body = response_body
    expect(last_response.status).to eq(404)
    expect(body.keys).to eq([:error])
  end

  it 'should return custom message to duplicate songs' do
    put("api/v1.0/albums/#{@album.id}/songs",
        song_id: @album.songs.sample.id)
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:error])
    expect(body[:error]).to eq('This song was already added to this album.')
  end
end
