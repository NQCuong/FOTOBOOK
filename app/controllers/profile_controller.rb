class ProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    @photo = current_user.photos.all
  end
end
