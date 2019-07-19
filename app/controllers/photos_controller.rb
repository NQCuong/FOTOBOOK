class PhotosController < ApplicationController
  before_action :authenticate_user!

  def new
    @photos = Photo.new
  end


  def create
    @photos = current_user.photos.build(photos_params)
    if @photos.save
      flash[:success] = "Photo has been added"
      redirect_to profile_index_path
    else @photos.save
      flash[:warning] = @photos.errors.full_messages.joins('. ')
      redirect_to :new
    end
  end

  private

  def photos_params
    params.require(:photo).permit(:title, :image, :description)
  end

end
