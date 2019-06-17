class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        remember_me
        redirect_back_or @user
      else
        flash[:warning] = t "mess_active"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "loginfail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def find_user
    @user = User.find_by email: params[:session][:email].downcase
  end

  def remember_me
    if params[:session][:remember_me] == Settings.remember_logic
      remember(@user)
    else
      forget(@user)
    end
  end
end
