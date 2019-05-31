class UsersController < ApplicationController
  before_action :select_user, only: :show

  def show
    return if @user

    flash[:danger] = t "notfound"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "static_pages.home.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def select_user
    @user = User.find_by id: params[:id]
  end
end
