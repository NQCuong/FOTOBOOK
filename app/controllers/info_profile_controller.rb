class InfoProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(params[:format])
    @photos =  @user.photos.all
    @albums =  @user.albums.all
    @followings = @user.following
    @followers = @user.followers
  end

  def follow
    current_user.following_relationships.create(following_id: params[:following_id])
    redirect_to profile_index_path

  end

  def unfollow
    follow = Follow.find_by(follower_id: current_user.id, following_id: params[:following_id])
    follow.destroy
    redirect_to profile_index_path
  end

  def edit
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:firtname, :lastname, :email, :password, :password_confirmation)
    end
end
