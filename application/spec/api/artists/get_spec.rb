require 'spec_helper'

describe 'GET /api/artists' do
  before :all do
    @user = create :user
    header('token', @user.token)
    @a1 = create :artist_with_albums
    @a2 = create :artist
  end

  it 'should pull all artists' do
    get "api/v1.0/artists"
    body = response_body
    names = body.map{ |x| x[:name] }
    expect(names).to include @a1.name
    expect(names).to include @a2.name
  end

  it 'should pull an artist' do
    get "api/v1.0/artists/#{@a1.id}"
    body = response_body
    expect(body[:name]).to eq @a1.name
  end

  it 'should return not found' do
    get "api/v1.0/artists/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
