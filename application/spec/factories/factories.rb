FactoryGirl.define do
  to_create { |instance| instance.save }
  factory :user, class: Api::Models::User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password Digest::MD5.hexdigest 'test'
    born_on Date.new(2000, 1, 1)
  end

  factory :artist, class: Api::Models::Artist do
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph }
    factory :artist_with_albums do
      transient do
        albums_count 5
      end

      after(:create) do |artist, evaluator|
        create_list(:album, evaluator.albums_count, artist: artist)
      end
    end
  end

  factory :album, class: Api::Models::Album do
    name { Faker::Name.name }
    album_art { Faker::Internet.url }
    association :artist, factory: :artist, strategy: :create
  end

  factory :song, class: Api::Models::Song do
    name { Faker::Name.name }
    genre { Faker::Name.name }
    banner { Faker::Name.name }
    promotion { Faker::Name.name }
    duration { Faker::Number.between(40, 500) }
    association :artist, factory: :artist, strategy: :build
    association :album, factory: :album, strategy: :build
    featured { [true, false].sample }
  end
end
