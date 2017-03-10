class Api
  resource :albums do
    get do
      #search by lupa
      albums = Models::Album.all
      Entities::Album.represent(albums)
    end

    post do
      result = CreateAlbumValidation.new(params).validate
      if result.success? && album = Models::Album.create(result.output)
        Entities::Album.represent(album)
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      album = Models::Album[params[:id]]
      return error!(:not_found, 404) unless album

      Entities::Album.represent(album)
    end

    put ':id' do
      album = Models::Album[params[:id]]
      return error!(:not_found, 404) unless album

      result = EditAlbumValidation.new(params).validate
      if result.success?
        album.update(result.output)
        Entities::Album.represent(album)
      else
        error!(result.messages, 400)
      end
    end
  end
end
