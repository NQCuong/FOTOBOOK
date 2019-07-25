class FeedController < ApplicationController
  before_action :authenticate_user!
  def like_photo
    @photo = Photo.find_by id: params[:id_photo]
    if current_user.liked? @photo
      @photo.disliked_by current_user
      render json: { messages: "unlike photo", obj: @photo, type: "unlike"}, status: 200
    else
      @photo.liked_by current_user
      render json: { messages: "like photo", obj: @photo, type: "like"}, status: 200
    end
  end

  def like_album
    @album = Album.find_by id: params[:id_album]
    puts current_user.liked? @album
    if current_user.liked? @album
      @album.disliked_by current_user
      render json: { messages: "unlike album", obj: @album, type: "unlike"}, status: 200
    else
      @album.liked_by current_user
      render json: { messages: "like album", obj: @album, type: "like"}, status: 200
    end
  end

  def index
    @users = User.all
    @photos = Photo.all.page(params[:page]).per(5)
    @albums =Album.all.page(params[:page]).per(5)
  end


  def destroy
    @photo = Photo.find_by id: params[:photo_id]
    @photo.disliked_by current_user
    respond_to do |format|
      format.html{redirect_to @photo}
      format.js{render :vote}
    end
  end
end
