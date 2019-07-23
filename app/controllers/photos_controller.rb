class PhotosController < ApplicationController
  before_action :authenticate_user!

  def new
    @photo = Photo.new
  end


  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo has been added"
      redirect_to profile_index_path
    else @photo.save
      flash[:warning] = @photo.errors.full_messages.joins('. ')
      redirect_to :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to profile_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    respond_to do |f|

      if @photo.destroy
        flash[:success] = "Successfully deleted photo!"

      else
        flash[:warning] = "Error deleting photo!"
      end

      f.html { redirect_to profile_index_path }
      f.js
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image, :description)
  end

end
