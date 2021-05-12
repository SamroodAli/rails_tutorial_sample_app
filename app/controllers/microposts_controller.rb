class MicropostsController < ApplicationController
  before_action :login_required, only: [:create, :destroy]

  def create
    @micropost = current_user.micropost.build(microposts_params)
  end

  def destroy
  end

  private
  def microposts_params
    params.require(:micropost).permit(:content)
  end

end
