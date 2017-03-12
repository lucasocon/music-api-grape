require 'spec_helper'

describe 'POST /api/songs' do
  before :all do
    @album = create :album
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

  it 'should create a new song' do
    post('api/v1.0/songs', @song_attributes)
    expect(last_response.status).to eq(201)
  end

  it 'missing params, should NOT create a new song' do
    post('api/v1.0/songs', {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name, :genre, :banner, :promotion, :duration, :featured])
  end

end
