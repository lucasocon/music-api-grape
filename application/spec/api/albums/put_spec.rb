require 'spec_helper'

describe 'PUT /api/albums' do
  before :all do
    @album = create :album
    @album_attributes = {
      name: Faker::Name.name,
      album_art: Faker::Lorem.paragraph
    }
  end

  it 'should update album attributes' do
    put("api/v1.0/albums/#{@album.id}", @album_attributes)
    expect(last_response.status).to eq(200)
  end

  it 'missing params, should NOT update album attributes' do
    put("api/v1.0/albums/#{@album.id}", {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name, :album_art])
  end

  it 'should return not found' do
    put "api/v1.0/albums/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
