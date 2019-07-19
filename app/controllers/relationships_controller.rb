class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @users = User.find(params[:following_id])
    current_user.follow(@users)
    respond_to do |format|
      format.html { redirect_to @users }
      format.js
    end
  end

  def destroy
    @users = Relationship.find(params[:id]).following
    current_user.unfollow(@users)
    respond_to do |format|
      format.html { redirect_to @users }
      format.js
    end
  end
end
