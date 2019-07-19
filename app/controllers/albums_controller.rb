class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def new
    @albums = Album.new
  end

  def create
    @albums = current_user.albums.build(albums_params)
    respond_to do |format|
      if @albums.save

        #Add lines bellow
        if params[:images]
          params[:images].each { |image|
          @albums.album_images.create(image: image)
        }
      end

        format.html { redirect_to profile_index_path, notice: 'Album was successfully created.' }
        format.json { render @albums, status: :created, location: @albums }
      else
        format.html { render :new }
        format.json { render json: @albums.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def albums_params
    params.require(:album).permit(:title, :description)
  end

end
