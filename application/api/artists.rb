class Api
  resource :artists do
    get do
      cached_response(Entities::Artist) { Models::Artist.all }
    end

    post do
      result = CreateArtistValidation.new(params).validate
      if result.success? && artist = Models::Artist.create(result.output)
        call_cache(Entities::Artist) { artist }
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      artist = cached_response(Entities::Artist) { Models::Artist[params[:id]]
      return error!(:not_found, 404) unless artist

      artist
    end

    put ':id' do
      artist = Models::Artist[params[:id]]
      return error!(:not_found, 404) unless artist

      result = EditArtistValidation.new(params).validate
      if result.success? && artist.update(result.output)
        call_cache(Entities::Artist) { artist }
      else
        error!(result.messages, 400)
      end
    end

    delete ':id' do
      artist = Models::Artist[params[:id]]
      return error!(:not_found, 404) unless artist
      artist.destroy
      call_cache(Entities::Artist) { artist }
    end
  end
end
