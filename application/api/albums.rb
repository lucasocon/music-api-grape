class Api
  resource :albums do
    get do
      cached_response(Entities::Album) { Models::Album.all }
    end

    post do
      result = CreateAlbumValidation.new(params).validate
      if result.success? && album = Models::Album.create(result.output)
        call_cache(Entities::Album) { album }
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      album = cached_response(Entities::Album) { Models::Album[params[:id]] }
      return error!(:not_found, 404) unless album

      album
    end

    put ':id' do
      album = Models::Album[params[:id]]
      return error!(:not_found, 404) unless album

      result = EditAlbumValidation.new(params).validate
      if result.success? && album.update(result.output)
        call_cache(Entities::Album) { album }
      else
        error!(result.messages, 400)
      end
    end

    delete ':id' do
      album = Models::Album[params[:id]]
      return error!(:not_found, 404) unless album
      album.destroy
      call_cache(Entities::Album) { album }
    end
  end
end
