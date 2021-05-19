class RelationshipsController < ApplicationController
  before_action :login_required, only: [:create, :destroy]

  def create
    @user = User.find(params[:followed_id])
    current_user.follows(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = relationship = Relationship.find(params[:id]).followed
    current_user.unfollows(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
