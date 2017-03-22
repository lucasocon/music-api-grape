require 'spec_helper'

describe 'GET /api/playlist' do
  before :all do
    @p1 = create :playlist
    @p2 = create :playlist
    @user = create :user
    header('token', @user.token)
  end

  it 'should pull all playlists' do
    get "api/v1.0/playlists"
    body = response_body
    names = body.map{ |x| x[:name] }
    expect(names).to include @p1.name
    expect(names).to include @p2.name
  end

  it 'should pull an playlist' do
    get "api/v1.0/playlists/#{@p1.id}"
    body = response_body
    expect(body[:name]).to eq @p1.name
  end

  it 'should return not found' do
    get "api/v1.0/playlists/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
