class FeedController < ApplicationController
  before_action :authenticate_user!
  def index
    @users =User.all
  end

  def like_photo
    @post = Photo.find_by id: params[:id_photo]
    puts current_user.liked? @post
    if current_user.liked? @post
      @post.disliked_by current_user
    else
      @post.liked_by current_user
    end
  end

  def like_album
    @post = Album.find_by id: params[:id_album]
    puts current_user.liked? @post
    if current_user.liked? @post
      @post.disliked_by current_user
    else
      @post.liked_by current_user
    end
  end
end
