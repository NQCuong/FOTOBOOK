class ProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    @photo = current_user.photos.all
    @album = current_user.albums.all
  end
end
