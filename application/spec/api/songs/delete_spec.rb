require 'spec_helper'

describe 'DELETE /api/songs' do
  before :all do
    @playlist = create(:playlist_with_songs)
    @song = Api::Models::Song.dataset.order{RANDOM{}}.first
  end

  it 'should delete song' do
    delete "api/v1.0/songs/#{@song.id}"
    expect(last_response.status).to eq(200)
    expect(Api::Models::Song.select_map(:id)).not_to include(@song.id)
    expect(Api::Models::PlaylistSong.select_map(:song_id)).not_to include(@song.id)
  end

  it 'should return not found' do
    delete "api/v1.0/songs/#{Api::Models::Song.max(:id) + 1}"
    expect(last_response.status).to eq(404)
  end
end
