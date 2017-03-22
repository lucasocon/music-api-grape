require 'spec_helper'

describe 'PUT /api/playlists' do
  before :all do
    @playlist = create :playlist
    @playlist_attributes = {
      name: Faker::Name.name
    }
    header('token', @playlist.user.token)
  end

  it 'should update playlist attributes' do
    put("api/v1.0/playlists/#{@playlist.id}", @playlist_attributes)
    expect(last_response.status).to eq(200)
  end

  it 'missing params, should NOT update playlist attributes' do
    put("api/v1.0/playlists/#{@playlist.id}", {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name])
  end

  it 'should return not found' do
    put "api/v1.0/playlists/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
