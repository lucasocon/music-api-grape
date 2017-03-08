class Api
  resource :playlists do
    get do
      # Search by lupa
      playlists = Models::Playlist.all
      Entities::Playlist.represent(playlists)
    end

    post do
      result = CreateAlbumValidation.new(params).validate
      if result.success? && playlist = Models::Playlist.create(result.output)
        Entities::Playlist.represent(playlist)
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      playlist = Models::Playlist[params[:id]]
      return error!(:not_found, 404) unless playlist

      Entities::User.represent(playlist)
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

    post ':id/songs' do
      playlist = Models::Playlist[params[:id]]
      return error!(:not_found, 404) unless playlist

      #service to add songs or bulk
    end

    delete ':id/songs' do
      playlist = Models::Playlist[params[:id]]
      songs_ids = params[:songs_ids] #array
      return error!(:not_found, 404) unless playlist

      Models::PlaylistsAlbums.where(playlist_id: playlist.id, song_id: songs_ids).destroy
      Entities::Playlist.represent(playlist.reload)
    end
  end
end
