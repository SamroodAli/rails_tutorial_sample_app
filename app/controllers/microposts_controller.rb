class MicropostsController < ApplicationController
  before_action :login_required, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(microposts_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    store_original_url
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer
  end

  private
  def microposts_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to login_url if @micropost.nil?
  end

end
