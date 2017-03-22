class Api
  resource :artists do
    before do
      authenticate!
    end

    get do
      artists = Models::Artist.all
      Entities::Artist.represent(artists)
    end

    post do
      result = CreateArtistValidation.new(params).validate
      if result.success? && artist = Models::Artist.create(result.output)
        Entities::Artist.represent(artist)
      else
        error!(result.messages, 400)
      end
    end

    get ':id' do
      artist = Models::Artist[params[:id]]
      return error!(:not_found, 404) unless artist

      Entities::Artist.represent(artist)
    end

    put ':id' do
      artist = Models::Artist[params[:id]]
      return error!(:not_found, 404) unless artist

      result = EditArtistValidation.new(params).validate
      if result.success?
        artist.update(result.output)
        Entities::Artist.represent(artist)
      else
        error!(result.messages, 400)
      end
    end

    delete ':id' do
      artist = Models::Artist[params[:id]]
      return error!(:not_found, 404) unless artist
      artist.destroy
    end
  end
end
