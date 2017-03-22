require 'spec_helper'

describe 'PUT /api/songs' do
  before :all do
    @user = create :user
    header('token', @user.token)
    @album = create :album
    @song = create :song
    @song_attributes = {
      name: Faker::Name.name,
      genre: Faker::Name.name,
      banner: Faker::Name.name,
      promotion: Faker::Name.name,
      duration: Faker::Number.between(40, 500),
      featured: [true, false].sample,
      album_id: @album.id
    }
  end

  it 'should update song attributes' do
    put("api/v1.0/songs/#{@song.id}", @song_attributes)
    expect(last_response.status).to eq(200)
  end

  it 'missing params, should NOT update song attributes' do
    put("api/v1.0/songs/#{@song.id}", {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name, :genre, :banner, :promotion, :duration, :featured])
  end

  it 'should return not found' do
    put "api/v1.0/songs/#{Api::Models::Song.max(:id) + 1}"
    expect(last_response.status).to eq(404)
  end
end
