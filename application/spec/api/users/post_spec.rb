require 'spec_helper'

describe 'POST /api/users' do
  before :all do
    password = Faker::Internet.password
    @user_attributes = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password,
      born_on: Faker::Date.birthday.to_time
    }
  end

  it 'should create a new user' do
    post('api/v1.0/users', @user_attributes)
    expect(last_response.status).to eq(201)
  end

  it 'should create a new user without born_on' do
    @user_attributes.delete(:born_on)
    post('api/v1.0/users', @user_attributes)
    expect(last_response.status).to eq(201)
  end

  it 'missing params, should NOT create a new user' do
    post('api/v1.0/users', {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:first_name, :last_name, :email, :password])
  end

  it 'wrong born_on format, should NOT create a new user' do
    @user_attributes[:born_on] = Faker::Date.birthday.to_s
    post('api/v1.0/users', @user_attributes)
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body).to eq(born_on: ['must be in format YYYY-MM-DD HH:MM:SS'])
  end
end
