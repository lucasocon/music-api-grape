require 'spec_helper'

describe 'POST /api/albums' do
  before :all do
    @artist = create :artist
    @album_attributes = {
      name: Faker::Name.name,
      album_art: Faker::Internet.url,
      artist_id: @artist.id
    }
  end

  it 'should create a new album' do
    post('api/v1.0/albums', @album_attributes)
    expect(last_response.status).to eq(201)
  end

  it 'missing params, should NOT create a new album' do
    post('api/v1.0/albums', {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name, :album_art, :artist_id])
  end

end
