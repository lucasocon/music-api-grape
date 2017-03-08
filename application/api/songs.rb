class Api
  resource :songs do
    get do
      # Search by lupa
      songs = Models::Song.all
      Entities::Song.represent(songs)
    end

    post do
      result = CreateSongValidation.new(params).validate
      if result.success? && song = Models::Song.create(result.output)
        Entities::Song.represent(song)
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      song = Models::Song[params[:id]]
      return error!(:not_found, 404) unless song

      Entities::User.represent(song)
    end

    put ':id' do
      song = Models::Song[params[:id]]
      return error!(:not_found, 404) unless song

      result = EditSongValidation.new(params).validate
      if result.success?
        song.update(result.output)
        Entities::User.represent(song)
      else
        error!(result.messages, 400)
      end
    end
  end
end
