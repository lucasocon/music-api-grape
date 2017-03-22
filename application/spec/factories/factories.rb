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
        albums_with_songs_count 5
      end

      after(:create) do |artist, evaluator|
        create_list(:album_with_songs, evaluator.albums_with_songs_count,
                    artist: artist)
      end
    end
  end

  factory :album, class: Api::Models::Album do
    name { Faker::Name.name }
    album_art { Faker::Internet.url }
    association :artist, factory: :artist, strategy: :create

    factory :album_with_songs do
      after(:create) do |album, evaluator|
        create_list(:song, 10)
        Api::Models::Song.each do |song|
          FactoryGirl.create(:albums_songs, album_id: album.id, song_id: song.id)
        end
      end
    end
  end

  factory :song, class: Api::Models::Song do
    name { Faker::Name.name }
    genre { Faker::Name.name }
    banner { Faker::Name.name }
    promotion { Faker::Name.name }
    duration { Faker::Number.between(40, 500) }
    featured { [true, false].sample }
  end

  factory :playlist, class: Api::Models::Playlist do
    name { Faker::Name.name }
    association :user, factory: :user, strategy: :create

    factory :playlist_with_songs do
      after(:create) do |playlist, evaluator|
        5.times { FactoryGirl.create(:album_with_songs) }
        songs = Api::Models::Song.dataset.order { RANDOM {} }.first(10)
        songs.each do |song|
          FactoryGirl.create(:playlists_songs, playlist_id: playlist.id, song_id: song.id)
        end
      end
    end
  end

  factory :playlists_songs, class: Api::Models::PlaylistSong do
    playlist
    song
  end

  factory :albums_songs, class: Api::Models::AlbumSong do
    album
    song
  end
end
