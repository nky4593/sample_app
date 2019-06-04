class UsersController < ApplicationController
  before_action :load_user, only: :show
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "updated"
      redirect_to @user
    else
      flash.now[:danger] = t "update_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "plslogin"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    begin
      redirect_to root_url unless @user.current_user? current_user
    rescue StandardError
      flash[:danger] = t "notfound"
      redirect_to root_url
    end
  end
end
