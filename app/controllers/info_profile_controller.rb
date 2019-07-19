class InfoProfileController < ApplicationController
  def index
    @users = User.find(params[:format])
    @photos =  @users.photos.all
    @albums =  @users.albums.all
    @followings = @users.following
    @followers = @users.followers
  end

  def follow
    Follow.create(follower_id:  current_user.id,following_id: params[:following_id])
    redirect_to profile_index_path

  end

  def unfollow
    follow = Follow.where(follower_id: current_user.id).where(following_id: params[:following_id]).first
    follow.destroy
    redirect_to profile_index_path
  end


end
