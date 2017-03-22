require 'spec_helper'

describe 'GET /api/songs' do
  before :all do
    @user = create :user
    header('token', @user.token)
    create :artist_with_albums
    @song = Api::Models::Song.dataset.order { RANDOM {} }.first
  end

  it 'should pull all songs' do
    get 'api/v1.0/songs'
    body = response_body
    response_names = body.map { |x| x[:name] }
    db_names = Api::Models::Song.dataset.select_map(:name)
    expect(response_names).to eq(db_names)
  end

  it 'should pull an song' do
    get "api/v1.0/songs/#{@song.id}"
    body = response_body
    expect(body[:name]).to eq @song.name
  end

  it 'should return not found' do
    get "api/v1.0/songs/#{Api::Models::Song.max(:id) + 1}"
    expect(last_response.status).to eq(404)
  end
end
