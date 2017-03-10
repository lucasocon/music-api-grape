require 'spec_helper'

describe 'GET /api/albums' do
  before :all do
    @a1 = create :album
    @a2 = create :album
  end

  it 'should pull all albums' do
    get "api/v1.0/albums"
    body = response_body
    names = body.map{ |x| x[:name] }
    expect(names).to include @a1.name
    expect(names).to include @a2.name
  end

  it 'should pull an artist' do
    get "api/v1.0/albums/#{@a1.id}"
    body = response_body
    expect(body[:name]).to eq @a1.name
  end

  it 'should return not found' do
    get "api/v1.0/albums/#{rand * 1000}"
    expect(last_response.status).to eq(404)
  end
end
