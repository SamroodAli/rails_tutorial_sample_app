class MicropostsController < ApplicationController
  before_action :login_required, only: [:create, :destroy]

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
  end

  private
  def microposts_params
    params.require(:micropost).permit(:content)
  end

end
