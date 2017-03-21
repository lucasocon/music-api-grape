class Api
  resource :playlists do
    get do
      playlists = Models::Playlist.all
      Entities::Playlist.represent(playlists)
    end

    post do
      result = CreatePlaylistValidation.new(params).validate
      if result.success? && playlist = Models::Playlist.create(result.output)
        Entities::Playlist.represent(playlist)
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      playlist = Models::Playlist[params[:id]]
      return error!(:not_found, 404) unless playlist

      Entities::Playlist.represent(playlist)
    end

    put ':id' do
      playlist = Models::Playlist[params[:id]]
      return error!(:not_found, 404) unless playlist

      result = EditPlaylistValidation.new(params).validate
      if result.success?
        playlist.update(result.output)
        Entities::Playlist.represent(playlist)
      else
        error!(result.messages, 400)
      end
    end

    put ':id/songs' do
      playlist = Models::Playlist[params[:id]]
      song = Models::Song[params[:song_id]]
      return error!(:not_found, 404) unless playlist && song

      song_to_add = Models::PlaylistSong.new(playlist_id: playlist.id, song_id: song.id)
      begin
        if song_to_add.save
          Entities::Playlist.represent(playlist)
        else
          error!("Fail to add song to the current playlist.", 400)
        end
      rescue Sequel::UniqueConstraintViolation
        error!("This song was already added to this playlist.", 400)
      end
    end

    delete ':id/songs' do
      playlist = Models::Playlist[params[:id]]
      song = Models::Song[params[:song_id]]
      return error!(:not_found, 404) unless playlist && song

      Models::PlaylistSong.where(playlist_id: playlist.id, song_id: song.id).destroy
      Entities::Playlist.represent(playlist)
    end

    delete ':id' do
      playlist = Models::Playlist[params[:id]]
      return error!(:not_found, 404) unless playlist

      playlist.destroy
    end
  end
end
