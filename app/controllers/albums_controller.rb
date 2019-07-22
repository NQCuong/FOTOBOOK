class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.build(album_params)
    respond_to do |format|
      if @album.save

        #Add lines bellow
        if params[:images]
          params[:images].each { |image|
          @album.album_images.create(image: image)
        }
      end

        format.html { redirect_to profile_index_path, notice: 'Album was successfully created.' }
        format.json { render @album, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end

end
