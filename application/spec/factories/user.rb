FactoryGirl.define do
  factory :user, class: Api::Models::User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password Digest::MD5.hexdigest 'test'
    born_on Date.new(2000, 1, 1)
  end
end
