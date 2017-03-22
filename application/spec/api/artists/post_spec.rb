require 'spec_helper'

describe 'POST /api/artist' do
  before :all do
    @user = create :user
    header('token', @user.token)
    @artist_attributes = {
      name: Faker::Name.name,
      bio: Faker::Lorem.paragraph
    }
  end

  it 'should create a new artist' do
    post('api/v1.0/artists', @artist_attributes)
    expect(last_response.status).to eq(201)
  end

  it 'missing params, should NOT create a new artist' do
    post('api/v1.0/artists', {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name, :bio])
  end

end
