require 'spec_helper'

describe 'DELETE /api/albums/:id/songs' do
  before :all do
    @album = create :album_with_songs
    @artist = create :artist_with_albums
  end

  it 'should remove song to album' do
    delete("api/v1.0/albums/#{@album.id}/songs", { song_id: @album.songs.sample.id })
    expect(last_response.status).to eq(200)
  end

  it 'should return not found' do
    delete("api/v1.0/albums/#{@album.id}/songs", { song_id: Api::Models::Song.max(:id) + 1 })
    body = response_body
    expect(last_response.status).to eq(404)
    expect(body.keys).to eq([:error])
  end
end
