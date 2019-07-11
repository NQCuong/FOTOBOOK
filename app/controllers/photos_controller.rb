class PhotosController < ApplicationController
  before_action :authenticate_user!
  def index
    @photo = Photo.order('created_at DESC')
  end

  def new
    @photo = Photo.new
  end

  def show
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.title.empty? | @photo.description.empty?
      flash[:warning] = "Title or Description was empty!"
      redirect_to new_photo_path
    else @photo.save
      flash[:success] = "Photo has been added"
      redirect_to profile_index_path
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image, :description)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
