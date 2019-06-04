class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create, destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build microposts_params

    if @micropost.save
      flash[:success] = t "micropost_create"
      redirect_to root_url
    else
      @feed_items = []
      flash.now[:danger] = t "micropost_fail"
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy

    if @micropost.destroyed?
      flash[:success] = t "micropost_delete"
    else
      flash[:danger] = t "micropost_delfail"
    end
    redirect_to request.referrer || root_url
  end

  private

  def microposts_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
