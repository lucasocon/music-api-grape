require 'spec_helper'

describe 'PATCH /api/users' do
  before :all do
    @user = create :user
    password = Faker::Internet.password
    @user_attributes = {
      new_password: password,
      new_password_confirmation: password
    }
  end

  it 'should update user password' do
    header('token', @user.token)
    patch("api/v1.0/users/#{@user.id}/reset_password", @user_attributes)
    expect(last_response.status).to eq(200)
  end

  it 'should NOT update user password, invalid token' do
    header('token', @user.token)
    @user2 = create :user
    patch("api/v1.0/users/#{@user2.id}/reset_password", @user_attributes)
    expect(last_response.status).to eq(401)
  end

  it 'missing params, should NOT update user password' do
    header('token', @user.token)
    patch("api/v1.0/users/#{@user.id}/reset_password", {})
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:new_password])
  end

  it 'mismatch passwords, should NOT update user password' do
    @user_attributes[:new_password] = Faker::Internet.password
    header('token', @user.token)
    patch("api/v1.0/users/#{@user.id}/reset_password", @user_attributes)
    body = response_body
    expect(last_response.status).to eq(400)
    expect(body.keys).to eq([:new_password_confirmation])
  end
end
