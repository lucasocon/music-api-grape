require 'spec_helper'

describe 'PUT /api/users' do
  before :all do
    @user = create :user
    @user_attributes = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      born_on: Faker::Date.birthday.to_time
    }
  end

  it 'should update user attributes' do
    header('token', @user.token)
    put("api/v1.0/users/#{@user.id}", @user_attributes)
    expect(last_response.status).to eq(200)
  end

  it 'should NOT update user attributes, invalid token' do
    header('token', @user.token)
    @user2 = create :user
    put("api/v1.0/users/#{@user2.id}", @user_attributes)
    expect(last_response.status).to eq(401)
  end

  it 'missing params, should NOT update user attributes' do
    header('token', @user.token)
    put("api/v1.0/users/#{@user.id}", {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:first_name, :last_name, :email])
  end

  it 'wrong born_on format, should NOT update user attributes' do
    @user_attributes[:born_on] = Faker::Date.birthday.to_s
    header('token', @user.token)
    put("api/v1.0/users/#{@user.id}", @user_attributes)
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body).to eq(born_on: ['must be in format YYYY-MM-DD HH:MM:SS'])
  end
end
