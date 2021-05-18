class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    current_user.follows(user)
    redirect_to user
  end


  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy
    redirect_to relationship.followed
  end

end
