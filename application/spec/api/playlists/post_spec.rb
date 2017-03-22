require 'spec_helper'

describe 'POST /api/playlists' do
  before :all do
    @user = create :user
    header('token', @user.token)
    @playlist_attributes = {
      name: Faker::Name.name,
      user_id: @user.id
    }
  end

  it 'should create a new playlist' do
    post('api/v1.0/playlists', @playlist_attributes)
    expect(last_response.status).to eq(201)
  end

  it 'missing params, should NOT create a new playlist' do
    post('api/v1.0/playlists', {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:name, :user_id])
  end
end
