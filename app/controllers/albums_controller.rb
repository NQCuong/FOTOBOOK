class AlbumsController < ApplicationController
  before_action :authenticate_user!
  def index
    @album = Album.order('created_at DESC')
  end

  def new
    @album = Album.new
  end

  def show
  end

  def create
    @album = Album.new(album_params)
    @album.user_id = current_user.id
    puts params
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

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end

  def set_photo
    @album = Album.find(params[:id])
  end
end
