class ProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    @photos = current_user.photos.all
    @albums = current_user.albums.all
    @followings = current_user.following
    @followers = current_user.followers
  end

end
