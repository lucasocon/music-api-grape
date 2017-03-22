require 'spec_helper'

describe 'PUT /api/artists' do
  before :all do
    @user = create :user
    header('token', @user.token)
    @artist = create :artist
    @artist_attributes = {
      name: Faker::Name.name,
      bio: Faker::Lorem.paragraph
    }
  end

  it 'should update artist attributes' do
    put("api/v1.0/artists/#{@artist.id}", @artist_attributes)
    expect(last_response.status).to eq(200)
  end

  it 'missing params, should NOT update artist attributes' do
    put("api/v1.0/artists/#{@artist.id}", {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name, :bio])
  end

  it 'should return not found' do
    put "api/v1.0/artists/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
