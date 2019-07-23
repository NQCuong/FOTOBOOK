class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.build(album_params)
      if @album.save

        #Add lines bellow
        if params[:images]
          params[:images].each { |image|
          @album.album_images.create(image: image)
        }
        end
        redirect_to profile_index_path
     end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      if params[:images]
        params[:images].each { |image|
        @album.album_images.update(image: image)
        }
      end
      redirect_to profile_index_path
    else
      render 'edit'
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end

end
