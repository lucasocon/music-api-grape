class Api
  resource :songs do
    get do
      cached_response(Entities::Song) { Models::Song.all }
    end

    post do
      result = CreateSongValidation.new(params).validate
      if result.success? && song = Models::Song.create(result.output)
        call_cache(Entities::Song) { song }
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      song = cached_response(Entities::Song) { Models::Song[params[:id]] }
      return error!(:not_found, 404) unless song

      song
    end

    put ':id' do
      song = Models::Song[params[:id]]
      return error!(:not_found, 404) unless song

      result = EditSongValidation.new(params).validate
      if result.success? && song.update(result.output)
        call_cache(Entities::Song) { song }
      else
        error!(result.messages, 400)
      end
    end

    delete ':id' do
      song = Models::Song[params[:id]]
      return error!(:not_found, 404) unless song
      song.destroy
      call_cache(Entities::Song) { song }
    end
  end
end
